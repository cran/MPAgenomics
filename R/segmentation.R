######################################
#'
#' This function launches the segmentation of a signal.
#'
#' @title segmentation function 
#'
#' @param signal A vector containing the signal.
#' @param Rho A vector containing all the penalization values to test for the segmentation. If no values are provided, default values will be used.
#' @param position A vector containing the position of all elements of the signal (not necessary)
#' @param plot if TRUE, plot the segmentation results
#' @param verbose if TRUE print some informations
#' 
#' @return a list containing
#' \describe{
#'   \item{signal}{A vector containing the signal.}
#'   \item{segmented}{A vector of the same size as signal containing the segmented values.}
#'   \item{startPos}{The position of each probe.}
#'   \item{segment}{A data.frame that summarizes the results of the segmentation. Each row is a different segment with the start position, end position, number of points in the signal and the value of the segment.}
#' }
#'
#' @export
#' 
#' @author Quentin Grimonprez
#' 
segmentation=function(signal,Rho=NULL,position=NULL,plot=TRUE,verbose=TRUE)
{
  seg=PELT(signal,Rho,position,plot,verbose)
  return(seg)
}

######################################
#'
#' This function launches the segmentation process using the aroma architecture.
#'
#' @title segmentation function 
#'
#' @param dataSetName The name of the data-set folder (it must correspond to a folder name in rawData folder.).
#' @param normalTumorArray Only in the case of normal-tumor study. A csv file or a data.frame containing the mapping between normal and tumor files
#' The first column contains the name of normal files and the second the names of associated tumor files.
#' @param chromosome A vector with the chromosomes to be segmented.
#' @param Rho A vector containing all the penalization values to test for the segmentation. If no values are provided, default values will be used.
#' @param onlySNP If TRUE, only the copy-number for SNPs positions will be returned (default=TRUE).
#' @param listOfFiles A vector containing the names of the files in dataSetName folder for which the copy number profiles will be segmented (default is all the files).
#' @param savePlot if TRUE, graphics of the segmented CN signal will be saved in the figures/dataSetName/segmentation/CN folder. (default=TRUE).
#' @param verbose if TRUE print some informations
#' 
#' @return a list containing
#' \describe{
#'   \item{copynumber}{A vector containing  the copynumber signal.}
#'   \item{segmented}{A vector of the same size as copynumber containing the segmented values.}
#'   \item{startPos}{The position of each probes.}
#'   \item{chromosome}{A vector of the same size as copynumber containing the chromosome number.}
#'   \item{featureNames}{Names of the probes.}
#'   \item{sampleNames}{The name of the signal.}
#'   \item{segment}{A data.frame that summarizes the results of the segmentation. Each row is a different segment with the chromosome, start position, end position, number of probes in the signal and the value of the segment.}
#' }
#'
#' @export
#' 
#' @author Quentin Grimonprez
#' 
segmentationAroma=function(dataSetName,normalTumorArray,chromosome=1:22,Rho=NULL,listOfFiles=NULL,onlySNP=TRUE,savePlot=TRUE,verbose=TRUE)
{
  seg=PELTaroma(dataSetName,normalTumorArray,chromosome,Rho,listOfFiles,onlySNP,savePlot,verbose)
  
  return(seg)
}