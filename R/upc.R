#' UPC model
#' 
#' Model per generar plantilles de la UPC
#' 
#' @export
#' 
upc <- function(fig_width = 4,
                fig_height = 2.5,
                fig_crop = TRUE,
                toc = FALSE,
                toc_depth = 2,
                number_sections = TRUE,
                highlight = "default",
                fig_caption = FALSE,
                keep_tex = FALSE,
                includes = NULL,
                pandoc_args = NULL) {
  
  # resolve default highlight
  if (identical(highlight, "default"))
    highlight <- "pygments"
  
  
  template <-  system.file(
    "rmarkdown/templates/upc/resources/default.tex", 
    package = "upcTemplate"
  )
  
  # call the base pdf_document format with the appropriate options
  format <- rmarkdown::pdf_document(fig_width = fig_width,
                                    fig_height = fig_height,
                                    fig_crop = fig_crop,
                                    highlight = "pygments",
                                    template = template,
                                    toc = toc,
                                    toc_depth = toc_depth,
                                    fig_caption = fig_caption,
                                    keep_tex = keep_tex,
                                    latex_engine = "pdflatex",
                                    includes = includes,
                                    pandoc_args = pandoc_args)
  
  
  # create knitr options (ensure opts and hooks are non-null)
  knitr_options <- rmarkdown::knitr_options_pdf(fig_width, fig_height, fig_crop)
  if (is.null(knitr_options$opts_knit))
    knitr_options$opts_knit <- list()
  if (is.null(knitr_options$knit_hooks))
    knitr_options$knit_hooks <- list()
  
  # set options
  knitr_options$opts_chunk$tidy <- TRUE
  knitr_options$opts_knit$width <- 45
  
  
  # override the knitr settings of the base format and return the format
  format$knitr <- knitr_options
  format
}