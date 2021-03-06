# This code uses Seurat v2.3.4 developed by the Satijalab
# The following Code shows how you can merge >2 Seurat objects
# All three objects xx, xy and xz were generated using CellRanger from a 10x output.
# It should work on Seurat v2.3.4
# Enjoy :)

install.packages('Seurat')
library(Seurat)


# this example is for a typical 10x CellRanger output, use other codes to create Seurat objects when non-10x platforms are used
# The first line of code points towards your directory, similarly for the other 2 samples as well :)

xx.data <- Read10X(data.dir = "~xx/filtered_feature_bc_matrix")
xx <- CreateSeuratObject(raw.data = xx.data,
                             project = "xx")

xy.data <- Read10X(data.dir = "~xy/filtered_feature_bc_matrix")
xy <- CreateSeuratObject(raw.data = xy.data,
                             project = "xy"
                             )

xz.data <- Read10X(data.dir = "~xz/filtered_feature_bc_matrix")
xz <- CreateSeuratObject(raw.data = xz.data,
                             project = "xz"
                             )

n2.combined <- MergeSeurat(object1 = xx, 
                               object2 = xy, 
                               add.cell.id1 = "xx",
                               add.cell.id2 = "xy",
                               do.normalize = FALSE,
                               project = "2samples"
                               )

n3.combined <- MergeSeurat(object1 = n2.combined, 
                               object2 = xz, 
                               add.cell.id2 = "xz",
                               do.normalize = FALSE,
                               project = "3samples"
                               )

# check tail and head for addition of sample specific ids 
tail(n3.combined@cell.names)
head(x = n3.combined@cell.names)

# to check cell number in the 2 sample combination and then the 3 sample combination
table(n2.combined@meta.data$orig.ident)
table(n3.combined@meta.data$orig.ident)
