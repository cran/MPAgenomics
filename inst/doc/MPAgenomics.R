### R code from vignette source 'MPAgenomics.Rnw'
### Encoding: UTF-8

###################################################
### code chunk number 1: MPAgenomics.Rnw:72-73 (eval = FALSE)
###################################################
## install.packages("MPAgenomics")


###################################################
### code chunk number 2: MPAgenomics.Rnw:76-77 (eval = FALSE)
###################################################
## vignette("MPAgenomics")


###################################################
### code chunk number 3: MPAgenomics.Rnw:83-91 (eval = FALSE)
###################################################
## source('http://callr.org/install#HenrikBengtsson/sfit')
## if (!requireNamespace("BiocManager", quietly = TRUE))
##     install.packages("BiocManager")
## BiocManager::install("affxparser")
## BiocManager::install("DNAcopy")
## BiocManager::install("aroma.light")
## install.packages("aroma.affymetrix")
## install.packages("aroma.cn")


###################################################
### code chunk number 4: MPAgenomics.Rnw:102-106 (eval = FALSE)
###################################################
## #Example of a working directory set up by the user
## #workdir="/home/user/Documents/workdir"
## workdir=tempdir()
## setwd(workdir)


###################################################
### code chunk number 5: MPAgenomics.Rnw:115-116 (eval = FALSE)
###################################################
## celPATH=paste0(workdir,"/cel")


###################################################
### code chunk number 6: MPAgenomics.Rnw:132-136 (eval = FALSE)
###################################################
## #untar the file
## download.file("https://nextcloud.univ-lille.fr/index.php/s/gxGr83BRMAJCBXd/download",
##   paste0(workdir,"/birdsuite_input.tgz"))
## untar("./birdsuite_input.tgz",exdir="cel")


###################################################
### code chunk number 7: MPAgenomics.Rnw:149-150 (eval = FALSE)
###################################################
## chipPATH=paste0(workdir,"/CD_GenomeWideSNP_6_rev3/Full/GenomeWideSNP_6/LibFiles/")


###################################################
### code chunk number 8: MPAgenomics.Rnw:156-163 (eval = FALSE)
###################################################
## #unzip required files
## download.file("http://www.affymetrix.com/Auth/support/downloads/library_files/genomewidesnp6_libraryfile.zip",
##   destfile = paste0(workdir,"/genomewidesnp6_libraryfile.zip"))
## unzip("./genomewidesnp6_libraryfile.zip",
##  files=c("CD_GenomeWideSNP_6_rev3/Full/GenomeWideSNP_6/LibFiles/GenomeWideSNP_6.Full.cdf"),exdir=".")
## #indicate the path containing .cdf files
## chipPATH=paste0(workdir,"/CD_GenomeWideSNP_6_rev3/Full/GenomeWideSNP_6/LibFiles/")


###################################################
### code chunk number 9: MPAgenomics.Rnw:183-184 (eval = FALSE)
###################################################
## renameFile(paste0(chipPATH,"GenomeWideSNP_6.Full.cdf"),paste0(chipPATH,"GenomeWideSNP_6,Full.cdf"))


###################################################
### code chunk number 10: MPAgenomics.Rnw:191-207 (eval = FALSE)
###################################################
## #set the directory where the .cdf files are as your working directory 
## setwd(chipPATH) 	
## ##download the 3 files .ufl, .ugp, .acs
## download.file("http://www.aroma-project.org/data/annotationData/chipTypes/GenomeWideSNP_6/GenomeWideSNP_6,Full,na31,hg19,HB20110328.ufl.gz",
## destfile="GenomeWideSNP_6,Full,na31,hg19,HB20110328.ufl.gz")
## download.file("http://www.aroma-project.org/data/annotationData/chipTypes/GenomeWideSNP_6/GenomeWideSNP_6,Full,na31,hg19,HB20110328.ugp.gz",
## destfile="GenomeWideSNP_6,Full,na31,hg19,HB20110328.ugp.gz")
## download.file("http://www.aroma-project.org/data/annotationData/chipTypes/GenomeWideSNP_6/GenomeWideSNP_6,HB20080710.acs.gz", 
## destfile="GenomeWideSNP_6,HB20080710.acs.gz")
## #unzip the gz files
## library(R.utils)
## gunzip("GenomeWideSNP_6,Full,na31,hg19,HB20110328.ufl.gz",
## destname="GenomeWideSNP_6,Full,na31,hg19,HB20110328.ufl")
## gunzip("GenomeWideSNP_6,Full,na31,hg19,HB20110328.ugp.gz",
## destname="GenomeWideSNP_6,Full,na31,hg19,HB20110328.ugp")
## gunzip("GenomeWideSNP_6,HB20080710.acs.gz",destname="GenomeWideSNP_6,HB20080710.acs")


###################################################
### code chunk number 11: MPAgenomics.Rnw:221-232 (eval = FALSE)
###################################################
## #list files to check that your path to annotation files (.cdf, .ugp, .ufl, .acs) is correctly set
## dir(chipPATH)
## # list files to check that your path to cel files (.cel) is correctly set
## dir(celPATH) 
## #set your working directory (where you have rights to write)
## setwd(workdir) 
## #load aroma.arrymetrix package
## library(aroma.affymetrix)
## #normalize data (might take several hours)
## signalPreProcess(dataSetName="datatest1", chipType="GenomeWideSNP_6",
## dataSetPath=celPATH,chipFilesPath=chipPATH, createArchitecture=TRUE, savePlot=TRUE, tags="Full")


###################################################
### code chunk number 12: MPAgenomics.Rnw:237-240 (eval = FALSE)
###################################################
## segcall=cnSegCallingProcess("datatest1",chromosome=c(1,5))
## #summary of segmentation and calling process
## segcall


###################################################
### code chunk number 13: MPAgenomics.Rnw:248-250 (eval = FALSE)
###################################################
## callfiltered=filterSeg(segcall,minLength=10,minProbes=2,keptLabel=c("gain","loss"))
## head(callfiltered)


###################################################
### code chunk number 14: MPAgenomics.Rnw:255-259 (eval = FALSE)
###################################################
## dataResponse=data.frame(files=getListOfFiles("datatest1"),
## response=c(2.105092,1.442868,1.952103,1.857819,2.047897,1.654766,2.385327,2.113406))
## res=markerSelection("datatest1",dataResponse,chromosome=21:22,signal="CN",
## onlySNP=TRUE,loss="linear")


###################################################
### code chunk number 15: MPAgenomics.Rnw:271-275 (eval = FALSE)
###################################################
## #get the file names of our data-set
## files=getListOfFiles("datatest1")
## #create the data.frame linking normal and tumor files
## normalTumorArray=data.frame(normal=files[1:4],tumor=files[5:8])


###################################################
### code chunk number 16: MPAgenomics.Rnw:289-292 (eval = FALSE)
###################################################
## addData(dataSetName="datatest2",dataPath=celPATH,chipType="GenomeWideSNP_6")
## signalPreProcess(dataSetName="datatest2", chipType="GenomeWideSNP_6",
## normalTumorArray=normalTumorArray, createArchitecture=FALSE, savePlot=TRUE, tags="Full")


###################################################
### code chunk number 17: MPAgenomics.Rnw:307-311 (eval = FALSE)
###################################################
## #run the segmentation
## segfracB=segFracBSignal("datatest2",chromosome=c(1,5),normalTumorArray = normalTumorArray)
## #print summary of segmentation
## segfracB


###################################################
### code chunk number 18: MPAgenomics.Rnw:377-378 (eval = FALSE)
###################################################
## createArchitecture("datatest1","GenomeWideSNP_6",celPATH,chipPATH,".",TRUE,"Full")


###################################################
### code chunk number 19: MPAgenomics.Rnw:689-696 (eval = FALSE)
###################################################
## #normal-tumor study
## CNdata2=getCopyNumberSignal("datatest2",5,normalTumorArray=normalTumorArray,TRUE)
## fracBdata2=getFracBSignal("datatest2",5,normalTumorArray=normalTumorArray)
## 
## #study without reference
## CNdata1=getCopyNumberSignal("datatest1",5,onlySNP=TRUE)	
## fracBdata1=getFracBSignal("datatest1",5)		


###################################################
### code chunk number 20: MPAgenomics.Rnw:700-704 (eval = FALSE)
###################################################
## CNdata2$chr5
## fracBdata2$chr5$tumor
## fracBdata2$chr5$normal
## fracBdata1$chr5$tumor


###################################################
### code chunk number 21: MPAgenomics.Rnw:781-784 (eval = FALSE)
###################################################
## file="GIGAS_g_GAINmixHapMapAffy2_GenomeWideEx_6_A02_31234"
## seg1=segmentationAroma("datatest1",chromosome=21:22,onlySNP=TRUE,savePlot=TRUE,
## listOfFiles=file)


###################################################
### code chunk number 22: MPAgenomics.Rnw:867-871 (eval = FALSE)
###################################################
## file="GIGAS_g_GAINmixHapMapAffy2_GenomeWideEx_6_A07_31314"
## CNdata1=getCopyNumberSignal("datatest1",20,onlySNP=TRUE,listOfFiles=file)
## copyNumber=CNdata1$chr20$GIGAS_g_GAINmixHapMapAffy2_GenomeWideEx_6_A07_31314
## position=CNdata1$chr20$position


###################################################
### code chunk number 23: MPAgenomics.Rnw:875-876 (eval = FALSE)
###################################################
## seg=segmentation(copyNumber,position=position,plot=TRUE,verbose=TRUE)


###################################################
### code chunk number 24: MPAgenomics.Rnw:882-883 (eval = FALSE)
###################################################
## seg$segment


###################################################
### code chunk number 25: MPAgenomics.Rnw:981-982 (eval = FALSE)
###################################################
## seg2=cnSegCallingProcess("datatest1",chromosome=21:22)


###################################################
### code chunk number 26: MPAgenomics.Rnw:1057-1064 (eval = FALSE)
###################################################
## #create the segmentData object
## callobj= callingObject(copynumber=seg$signal, segmented=seg$segmented,
##  chromosome=rep(20,length(seg$signal)), position=seg$startPos, 
##  sampleNames="sample1")
## #run the calling
## call=callingProcess(callobj,nclass=3,cellularity=1,verbose=TRUE)
## call$segment


###################################################
### code chunk number 27: MPAgenomics.Rnw:1129-1131 (eval = FALSE)
###################################################
## segmentfilter=filterSeg(call$segment,keptLabel="gain")
## segmentfilter


###################################################
### code chunk number 28: MPAgenomics.Rnw:1224-1228 (eval = FALSE)
###################################################
## dataResponse=data.frame(files=getListOfFiles("datatest1"),
## response=c(2.105092,1.442868,1.952103,1.857819,2.047897,1.654766,2.385327,2.113406))
## res=markerSelection(dataSetName="datatest1",dataResponse,chromosome=21:22,signal="CN",
## onlySNP=TRUE,loss="linear")


###################################################
### code chunk number 29: MPAgenomics.Rnw:1276-1279 (eval = FALSE)
###################################################
## dataMatrix=matrix(rnorm(5000,0,0.5),nrow=50)
## dataResponse=drop(dataMatrix%*%sample(c(rep(0,90),rep(1,10))))
## res=variableSelection(dataMatrix,dataResponse,nbFolds=5,loss="linear",plot=TRUE)


