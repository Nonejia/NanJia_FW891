{
  rm(list=ls());  options(show.error.locations = TRUE);
  
  # sp needs to be installed before sf package but you will still
  # get an error about sp not being installed -- this can be ignored
  library(package = "sp");       #old Simple Features (but still needed)
  library(package = "rgeos");    # getting/converting crs
  library(package = "rgdal");    # getting/converting crs
  library(package = "ggplot2");
  library(package = "dplyr");
  library(package = "sf");       # Simple Features
  library(package = "rnaturalearth");     # for getting coord data
  library(package = "rnaturalearthdata");
  
  #### Application 11a #####
  #   Add three new points to the data frame 
  #   - use only one SF
  #   - make each point a different color, size, and shape
  #   - make sure the bounding box does not change because of the new points
  
  pointDF = data.frame(
    northing = c(10000000, 11000000,11000000),
    easting = c(-1000000, -1500000,-1400000));
  
  ## Convert the data frame to an SF and include the CRS
  pointDF_SF = st_as_sf(pointDF,
                        coords = c("northing", "easting"),  # yes, this is opposite of lon,lat
                        crs = 3593); # this number is the original CRS
  plot1 = ggplot() +
    geom_sf(data = museums_SF2,
            mapping = aes(geometry = geometry),
            color = "red") +
    
    geom_sf(data = pointDF_SF,
            mapping=aes(geometry=geometry),
            color = c("green","blue","yellow")) +
    coord_sf(crs = 26917);   # changing CRS
  plot(plot1);
  
  #### Application #####
  #   Create a new type of shapefile from your own data file
  #     - in R, create a SF from your data
  #     - in R, save the SF in a different format (KML, geoJSON, SHP)
  #   Open the new shapefile in R and plot it
  
  cities = st_read(dsn = "data/city.csv");
  cities_SF2 = st_as_sf(cities, 
                        coords = c("lng", "lat"),
                        crs = 4326);
  if(!file.exists("data/city.kml"))
  {
    # Shapefiles create 4 files: shp, shx, dbf, proj
    st_write(museums_SF, dsn = "data/city.kml", 
             driver = "kml");
  }
  if(!file.exists("data/city.shp"))
  {
    st_write(museums_SF, dsn = "data/city.shp", 
             driver = "ESRI Shapefile");
  }
  if(!file.exists("data/city.geojson"))
  {
    st_write(museums_SF, dsn = "data/city.geojson", 
             driver = "GeoJSON");
  }
  cities_GEO = st_read(dsn="data/city.geojson");
  cities_GEO_SF = st_as_sf(cities_GEO);
  plot2 = ggplot() +
    geom_sf(data = cities_GEO_SF,  # replace with any of the shape files above
            mapping = aes(geometry = geometry),
            color = "red");
  plot(plot2);
  
  #### Application #####
  #   Add a color mapping that distinguishes presidential library from 
  #     non-presidential libraries (it's a column in the data frame...)
  #   Change the default mapped colors using style_* component 
  plot3 = ggplot() +
    geom_sf(data = states_SF,
            mapping = aes(geometry = geometry),
            color = "black",
            fill = "grey80") +
    geom_sf(data = lakes_SF,
            mapping = aes(geometry = geometry),
            color = "lightblue",
            fill = "lightblue") +
    geom_sf(data = lakeMI_SF,
            mapping = aes(geometry = geometry),
            color = "blue",
            fill = "blue")+
    geom_sf_label(data = museums_SF,
                  mapping = aes(geometry=geometry, 
                                label=substr(museum,start=1,stop=3), 
                                fill = Presidential.Library))+
    labs(color = "Scale Rank",
         fill = "Presidental Library",
         linetype = "Region");
  plot4 = plot4 +
    coord_sf(crs = 4326,    
             xlim = c(-120, -70), 
             ylim = c(20, 60),
             expand = TRUE);
  plot(plot4);
  
  #### 4)	Change properties of the mappings (uses lesson11e.Mappings.R):
  plot6 = ggplot() +
    geom_sf(data = lakes_SF,
            mapping = aes(geometry = geometry, color=scalerank),
            fill = "lightblue") +
    scale_color_gradient(low = "yellow", high = "purple")+
    geom_sf(data = states_SF,
            mapping = aes(geometry = geometry, fill=region, linetype=type),
            color = "black") +
    scale_fill_manual(values = c("pink", "purple", "seagreen", "brown2"))+
    scale_linetype_manual(values = c("solid", "dashed"))+
    geom_sf_text(data = states_SF,
                 mapping = aes(geometry=geometry, label=postal),
                 color="lightyellow") + 
    geom_sf(data = museums_SF,
            mapping = aes(geometry = geometry, shape=Presidential.Library),      
            color = "red", 
            size = 4) +
    scale_shape_manual(values = c(18,17))+
    geom_sf(data = lakeMI_SF,
            mapping = aes(geometry = geometry),
            color = "blue",
            fill = "blue")+
    labs(color = "Lake Scale Rank",
         fill = "Region",
         linetype = "Postal District", 
         shape = "Presidential Library");
  
  plot7 = plot6 +
    coord_sf(crs = 4326,    
             xlim = c(-120, -70),  
             ylim = c(20, 60),
             expand = TRUE);
  plot(plot7);
  
  
}