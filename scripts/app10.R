{ 
  ##############################################################################
  ################################ Answers of HW 10 ########################
  ##############################################################################
  # Q2
  # Since both of the False Northing and False Easting acquire from the
  # false origin point, to prevent no negative numbers when setting coordinates,
  # UTM grids added 500 km linear values to central meridian, and added 1000 km 
  # to the north equator, so whether the point is, there will be no negative
  # numbers.
  
  
  rm(list=ls());  options(show.error.locations = TRUE);
  
  # sp needs to be installed before sf package but you will still
  # get an error about sp not being installed -- this can be ignored
  library(package = "sp");       # old Simple Features (but still needed)
  library(package = "rgeos");    # getting/converting crs
  library(package = "rgdal");    # getting/converting crs
  library(package = "ggplot2");
  library(package = "sf");       # Simple Features
  library(package = "rnaturalearth");     # for getting coord data
  library(package = "rnaturalearthdata"); # for getting coord data
  
  ### How I downloaded the lakes... can someone test this code.
  # lakes110 = ne_download(scale = 110, type = 'lakes', category = 'physical')
  
  # read in data from a csv file with spatial data
  museums = st_read(dsn="data/museum.csv");
  
  ## When you convert a CSV to a simple feature, you need to
  #   supply the longitude and latitude columns (in that order)
  museums_SF1 = st_as_sf(museums, 
                         coords = c("lng", "lat")); 
  
  #### look for Geodetic CRS in simple feature
  ## The above SF has no crs -- will cause error when plotting
  #   error: cannot transform sfc object with missing crs
  
  # add the crs so it can be plotted
  museums_SF2 = st_as_sf(museums, 
                         coords = c("lng", "lat"),
                         crs = 4326);  # it's a guess since no crs info was given
  
  #Q3
  #### Group 1:
  #  Using a text editor (RStudio is a text editor):    
  #    Create a CSV file that has lat/long for Detroit, Chicago, and Toronto
  #  Create a Simple Feature from the file
  
  cities = st_read(dsn = "data/city.csv");
  cities_SF1 = st_as_sf(cities, 
                        coords = c("lng", "lat"));
  cities_SF2 = st_as_sf(cities, 
                        coords = c("lng", "lat"),
                        crs = 4326);
  cities_SF2
  
  
  ## KML files are google map files (similar to HTML files)
  #  KMZ files are also google map files that have been zipped
  lakeMichigan = st_read(dsn="data/Lake_Michigan_shoreline.kml");
  # KML files have the lat, long, and crs built in  -- you (usually) do not need to declare it
  lakeMI_SF = st_as_sf(lakeMichigan); 
  
  ## SHP file are shapefiles (probably the most popular -- ArcGIS)
  #  They are not standalone files!
  # Get the lake borders from downloaded file
  lakes = st_read(dsn="data/lakes/ne_10m_lakes.shp");  
  lakes_SF = st_as_sf(lakes); 
  
  ### Getting data from a database (in this case, from naturalearth.com)
  #    The database sends a data file -- which types depends on the database
  # get the state borders from naturalearth
  states = ne_states(country = "United States of America");
  states_SF = st_as_sf(states);
  
  #### https://www.naturalearthdata.com/  (can get shapefiles from here)
  #### https://rdrr.io/cran/rnaturalearth/api/ (R interface to naturalearth website)
  #### https://gis-michigan.opendata.arcgis.com (Michigan shapefiles)
  
  # Remember that later component layer on top of earlier components
  plot1 = ggplot() +
    geom_sf(data = states_SF,
            mapping = aes(geometry = geometry),
            color = "black",
            fill = "grey") +
    geom_sf(data = lakes_SF,
            mapping = aes(geometry = geometry),
            color = "lightblue",
            fill = "lightblue") +
    geom_sf(data = museums_SF2,
            mapping = aes(geometry = geometry),      
            color = "red", 
            fill = "red") +
    geom_sf(data = lakeMI_SF,
            mapping = aes(geometry = geometry),
            color = "blue",
            fill = "blue");
  
  plot2 = plot1 +
    # 4326 will default to Mercator projection...
    coord_sf(crs = 4326,    
             xlim = c(-120, -70),  # in degrees...
             ylim = c(20, 60),
             expand = TRUE);
  plot(plot2);
  
  ### Often need to click Zoom button in Plot window to see full map
  plot3 = plot1 +
    coord_sf(crs = 26917,   # UTM 17N
             xlim = c(-3000000, 2000000),  # note the negative number (false easting)
             ylim = c(3000000, 7000000),
             expand = TRUE);
  plot(plot3);
  
  
  # Q4 & Q5
  ####Group 2
  # - Zoom this map into Great Lakes region
  # - Use UTM 14N (CRS = 26914)
  # - add Canada to the map (from naturalearth.com or using ne_download()
  # - add Lake Erie to the map (download from Michigan arcgis)
  # - add Detroit, Chicago, Toronto as points to the map
  # - Do the same plot with 2 other CRS 
  
  plot4 = plot3+
    coord_sf(crs = 26914,  
             xlim = c(1000000, 2500000),  # note the negative number (false easting)
             ylim = c(4490000, 550000),
             expand = TRUE);
  plot(plot4);
  
  canada = ne_states(country = "Canada");
  canada_SF = st_as_sf(canada);
  
  lakeErie = st_read(dsn="data/Lake_Erie_Shoreline.kml");
  lakeErie_SF = st_as_sf(lakeErie);
  
  cities_SF3 = st_as_sf(cities, 
                        coords = c("lng", "lat"),
                        crs = 26914);
  
  plot5 = ggplot() +
    geom_sf(data = canada_SF,
            mapping = aes(geometry = geometry),
            color = "black",
            fill = "pink") +
    geom_sf(data = states_SF,
            mapping = aes(geometry = geometry),
            color = "black",
            fill = "lightyellow") +
    geom_sf(data = lakes_SF,
            mapping = aes(geometry = geometry),
            color = "lightblue",
            fill = "lightblue") +
    geom_sf(data = museums_SF2,
            mapping = aes(geometry = geometry),      
            color = "brown1", 
            fill = "brown1") +
    geom_sf(data = lakeMI_SF,
            mapping = aes(geometry = geometry),
            color = "cyan2",
            fill = "cyan2")+
    geom_sf(data = lakeErie_SF,
            mapping = aes(geometry = geometry),
            color = "cornflowerblue",
            fill = "cornflowerblue")+
    geom_sf(data = cities_SF3,
            mapping = aes(geometry = geometry),  
            color = "gold",    
            fill = "gold")+
    geom_sf_label(data = cities_SF2,
                  mapping = aes(geometry=geometry, label=substr(abbreviation,2,4)),
                  color="purple",
                  fill = "yellow",
                  nudge_x = 10) + 
    coord_sf(crs = 26914,   
             xlim = c(500000, 2500000), 
             ylim = c(450000, 7000000),
             expand = TRUE);
  plot(plot5)
  
  # Q6

  china = st_read(dsn = "data/china/China.shp");
  china_SF = st_as_sf(china);
  
  plot6 = ggplot()+
    geom_sf(data = china_SF,
            mapping = aes(geometry = geometry),
            color = "cornflowerblue",
            fill = "cornflowerblue")+
    coord_sf(crs = 4326,    
             xlim = c(73, 135),  # in degrees...
             ylim = c(4, 54),
             expand = TRUE);
  plot(plot6)
  
  ##Searchable list of CRS numbers:
  # https://spatialreference.org/ref/epsg/  
  
  
  ### Homework: Create a map using your shapefile
  #   - make sure you have an appropriate background map
  #   - have an appropriate crs and axes zoomed appropriately 
  
  ### Next:
  #   Manually add lines ####
  #   Manually add text ####
  #   Style mappings (e.g., color the regions)
  
}

