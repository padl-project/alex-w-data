# This script executes an EMLassemblyline workflow.

# Initialize workspace --------------------------------------------------------

# Update EMLassemblyline and load

remotes::install_github("EDIorg/EMLassemblyline")
library(EMLassemblyline)

# Define paths for your metadata templates, data, and EML

path_templates <- paste0(getwd(), "/edi.1027/metadata_templates")
path_data <- paste0(getwd(), "/edi.1027/data_objects")
path_eml <- paste0(getwd(), "/edi.1027/eml")


# Create metadata templates ---------------------------------------------------

# Below is a list of boiler plate function calls for creating metadata templates.
# They are meant to be a reminder and save you a little time. Remove the 
# functions and arguments you don't need AND ... don't forget to read the docs! 
# E.g. ?template_core_metadata

# Create core templates (required for all data packages)

EMLassemblyline::template_core_metadata(
  path = path_templates,
  license = "CCBY",
  file.type = ".docx")

# Create table attributes template (required when data tables are present)

EMLassemblyline::template_table_attributes(
  path = path_templates,
  data.path = path_data,
  data.table = "2004_2008_Awegmann_Palmyra_Atoll_OSP.csv")

# Create categorical variables template (required when attributes templates
# contains variables with a "categorical" class)

EMLassemblyline::template_categorical_variables(
  path = path_templates, 
  data.path = path_data)

# Create geographic coverage (required when more than one geographic location
# is to be reported in the metadata).

# EMLassemblyline::template_geographic_coverage(
#   path = path_templates, 
#   data.path = path_data, 
#   data.table = "", 
#   lat.col = "",
#   lon.col = "",
#   site.col = "")



# Create taxonomic coverage template (Not-required. Use this to report 
# taxonomic entities in the metadata)

# remotes::install_github("EDIorg/taxonomyCleanr")
# library(taxonomyCleanr)
# 
# taxonomyCleanr::view_taxa_authorities()
# 
# EMLassemblyline::template_taxonomic_coverage(
#   path = path_templates, 
#   data.path = path_data,
#   taxa.table = "2004_2008_Awegmann_Palmyra_Atoll_OSP.csv",
#   taxa.col = "species",
#   taxa.name.type = "scientific",
#   taxa.authority = 3)

# Make EML from metadata templates --------------------------------------------

# Once all your metadata templates are complete call this function to create 
# the EML.


EMLassemblyline::make_eml(
  path = path_templates,
  data.path = path_data,
  eml.path = path_eml, 
  dataset.title = "Palmyra Atoll Cocos nucifera Open Solar Path impact study", 
  temporal.coverage = c("2004-08-04", "2008-04-07"), 
  geographic.description = "Palmyra Atoll", 
  geographic.coordinates = c("5.88333", "-162.043", "5.871", "-162.083"), 
  maintenance.description = "Completed", 
  data.table = c("2004_2008_Awegmann_Palmyra_Atoll_OSP.csv"), 
  data.table.name = c("Palmyra Atoll Cocos nucifera Open Solar Path impact study"),
  data.table.description = c("Native tree growth and reproduction in response to reduction in the coconut palm (Cocos nucifera) canopy at Palmyra Atoll"),
  user.id = "palmyra_project",
  user.domain = "EDI", 
  package.id = "1027.2")
