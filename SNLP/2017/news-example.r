require(ggplot2)
require(grid)
require(gridExtra)
require(scales)

args <- commandArgs(trailingOnly=T)

fontsize <-26
fontsize.label <- 9.5
fontsize.spanlabel <- 9.5
ylim <- c(19200, 19600)

convd <- function(x) {
    ns <- as.integer(strsplit(as.character(x), "/")[[1]])
    d <- ns[2]
    m <- ns[1]
    y <- ns[3]
    return(sprintf("%04d-%02d-%02d", y, m, d))
}

yesterday <- read.csv("20161219.csv", header=F, sep=",")
today <- read.csv("20161220.csv", header=F, sep=",")
values.yesterday <- yesterday[, 6][50:62]
n <- length(values.yesterday)
breaktime <- rep(NA, 11)
skip <- length(breaktime)
values <- c(values.yesterday,
            rep(NA, skip),
            today[, 6][1:31],
            breaktime,
            today[, 6][32:62])

df <- data.frame(Time=1:length(values), Price=values)

g <- ggplot(df, aes(x=Time, y=Price)) +
    geom_line(size=1.1) +
    ylab("") +
    xlab("") +
    coord_cartesian(ylim=ylim) +
    scale_x_continuous(breaks=seq(1, 108, by=12),
                       labels=c("14:00",
                                "15:00",
                                "9:00",
                                "10:00",
                                "11:00",
                                "12:00",
                                "13:00",
                                "14:00",
                                "15:00"),
                       minor_breaks=NULL) +
    theme(text=element_text(size=fontsize),
          axis.text.x=element_text(size=fontsize, colour="black"),
          axis.title.x=element_text(size=fontsize, margin=margin(15, 0, 0, 0)),
          axis.text.y=element_text(size=fontsize, colour="black"),
          axis.title.y=element_text(size=fontsize, margin=margin(0, 15, 0, 0)),
          plot.title=element_text(hjust=0.5, margin=margin(0, 0, 15, 0)))

j <- 1
for (i in c(n + skip + 1,
            n + skip + 7,
            n + skip + 31,
            n + skip + 32 + length(breaktime),
            n + skip + 49 + length(breaktime),
            length(values))) {
    point <- df[i,]

    y <- 40
    labelpoint <- data.frame(df[i,]$Time, df[i,]$Price + y, j)
    colnames(labelpoint) <- c("Time", "Price", "Index")
    g <- g +
        geom_point(data=point,
                   size=3,
                   colour="red") +
        geom_text(data=labelpoint,
                  aes(x=Time, y=Price, label=sprintf("(%d)", Index)),
                  size=fontsize.label)
    j <- j + 1
}

arrow.thickness <- 0.7
arrow.size <- unit(0.3, "cm")
arrow.y <- 19340

g <- g +
    geom_segment(aes(x=(n + 6), y=(0.96 * ylim[1]), xend=(n + 6), yend=(1.04 * ylim[2])),
                 colour="white",
                 size=10) +
    geom_segment(aes(x=1, y=arrow.y, xend=13, yend=arrow.y),
                 colour="red",
                 size=arrow.thickness,
                 arrow=arrow(ends="both", length=arrow.size)) +
    geom_segment(aes(x=(n + skip + 1), y=arrow.y, xend=(n + skip + 31), yend=arrow.y),
                 colour="red",
                 size=arrow.thickness,
                 arrow=arrow(ends="both", length=arrow.size)) +
    geom_segment(aes(x=(n + skip + 32 + skip), y=arrow.y, xend=length(values), yend=arrow.y),
                 colour="red",
                 size=arrow.thickness,
                 arrow=arrow(ends="both", length=arrow.size))

    y <- 19320

    labelpoint <- data.frame(Time=7, Price=y)
    colnames(labelpoint) <- c("Time", "Price")
    g <- g +
        geom_text(data=labelpoint,
                  aes(x=Time, y=Price, label="後場\n（前取引日）"),
                  vjust=1,
                  size=fontsize.spanlabel)

    labelpoint <- data.frame(Time=40, Price=y)
    colnames(labelpoint) <- c("Time", "Price")
    g <- g +
        geom_text(data=labelpoint,
                  aes(x=Time, y=Price, label="前場"),
                  vjust=1,
                  size=fontsize.spanlabel)

    labelpoint <- data.frame(Time=81.5, Price=y)
    colnames(labelpoint) <- c("Time", "Price")
    g <- g +
        geom_text(data=labelpoint,
                  aes(x=Time, y=Price, label="後場"),
                  vjust=1,
                  size=fontsize.spanlabel)


cairo_pdf("news-example.pdf", width=12, height=8.5, family=args[1])
plot(g)
dev.off()
