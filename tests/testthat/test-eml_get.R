testthat::context("eml_find and eml_get")

f = tempfile()
download.file("https://knb.ecoinformatics.org/knb/d1/mn/v2/object/doi%3A10.5063%2FF1BZ63Z8",f)
eml = read_eml(f)

testthat::test_that("we can find and get an element", {

  m <- eml_get(eml, "methods") 
  testthat::expect_is(m, "methods")
  m <- eml_find(eml, "methods") # ok
  testthat::expect_is(m, "methods")

})


testthat::test_that("we can get child elements from arbitrary nodes", {
  
  geographicCoverage <- eml_get(eml, "geographicCoverage") #works
  
  # Note, this returns a list of all ListOfgeographicCoverage nodes...
  testthat::expect_is(geographicCoverage[[1]][[1]], "geographicCoverage")
  
  ## How about an individual character-type element?
  x <- eml_get(geographicCoverage, "geographicDescription")
  testthat::expect_is(x, "character")
  
  ## The fast way?
  eml_get(eml, "geographicDescription")  #return NULL

})