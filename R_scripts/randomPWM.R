rm(list = ls())
#randomly pick score out of human PWM

#
# randomly pick a S_NT_position and sum up each 1 million times
#
#
#
# graph score vs freq histogram
#
# should be exponential / poisson distrubtion
#

human.filename = "rna30upstream_and_CDS.fasta"

#make a pwm of size 13
human = readDNAStringSet(human.filename)
human.kozak = DNAStringSet(subseq(human, start = 22, end = 34))
consensusMatrix(human.kozak)
consensusString(human.kozak)

for (x in 1:2) {
  human.pwm = NULL
  raw.data = NULL
  
  if (x == 1) {
    PWM.type = "log2probratio"
  } else if (x == 2) {
    PWM.type = "prob"
  }
  
  human.pwm    = PWM(human.kozak, type = PWM.type)
  
  num.random.samples = 100000
  
  raw.data <- numeric(length = num.random.samples)
  
  #loop unrolling
  print(system.time(for (i in 1:length(raw.data)) {
    raw.data[i] <- (
      sample(human.pwm[1:4], 1) +
        sample(human.pwm[5:8], 1) +
        sample(human.pwm[9:12], 1) +
        sample(human.pwm[13:16], 1) +
        sample(human.pwm[17:20], 1) +
        sample(human.pwm[21:24], 1) +
        sample(human.pwm[25:28], 1) +
        sample(human.pwm[29:32], 1) +
        sample(human.pwm[33:36], 1) +
        sample(human.pwm[37:40], 1) +
        sample(human.pwm[41:44], 1) +
        sample(human.pwm[45:48], 1) +
        sample(human.pwm[49:52], 1)
    )
  }))
  
  if (x == 1) {
    unlisted.data.1 <- unlist(raw.data)
    
    #lines(density(unlisted.data, adjust = 2), col = "green", lwd = 2, lty = "dotted")
  } else if (x == 2) {
    unlisted.data.2 <- unlist(raw.data)
  }
}


hist(
  unlisted.data.2,
  freq = FALSE,
  breaks = num.random.samples / 15,
  xlab = "scores",
  main = paste(num.random.samples, "random samples| PWM type = ", PWM.type)
)
lines(density(unlisted.data.2), col = "blue", lwd = 2)

# library(plotrix)
# colors <- c("red", "blue")
# datafoo <- list(unlisted.data, unlisted.data2)
# multhist(datafoo, lty = "blank" ,breaks = num.random.samples/100, col = colors, freq = FALSE)
# lines(density(datafoo[[1]]))
# legend("topright", c("log2probratio", "prob"), fill = colors)
#
#
#
#
#
