# You need this package as a dependency?
install.packages("stringi")
# Install the bioseq package
install.packages("bioseq")
# And load it
library("bioseq")

# Let's start with some DNA
seq <- dna("ATGGCCATGGCGCCCAGAACTGAGATCAATAGTACCCGTATTAACGGGTGA")
# Then translate it into protein and print
print(seq_translate(seq))
