## Goal
- Fully implement and update the Explore tab - ensure all posters are displayed, as well as the movies / tv shows are connected to their respective details pages, and that the scrolling lists are fully functional.
- Finish up the Search tab functionality and enhance the visual appeal of it a bit more.
- Start structuring the skeleton of the Browse tab, including the layouts, structural layers, and the visuals. Also create the layout for the filter option.
- Create the TV shows details page and finalize the Movie details page.
## Tasks - user stories
_As a user, (story points)_
- (149) As a user, I want to find detailed information about a specific movie or TV show.
  - [x] Task 1 (3): Display the genre
  - [ ] Task 2 (2): Display the status ([released, in production, canceled])
  - [ ] Task 3 (2): Display the revenue of the movie
  - [x] Task 4 (2): Display the rating of the movie 
  - [ ] Task 5 (13): Display the reviews of a movie [as some sort of scrolling list
  - [x] Task 6 (5): Display the movie trailer
- (55) As a user, I want to be able to browse movies by genres. 
  - [x] Task 1 (8): Develop the layout of the scrolling lists and the different categories / sub-categories
  - [x] Task 2 (8): Develop a secondary page layout for the browse when clicking on a genre
  - [ ] Task 3 (5): Getting the poster and title of the movie displayed on the secondary page
  - [x] Task 4 (5): Develop the non-working visual display for filtering option
  - [x] Task 5 (1): On the getDetails method call, cap the number of images that are created. 
  - [x] Task 6 (5): Consult API documentation, and implement more get methods to list on the browse page. I.e. look into end points for things like ‘oscar nominated’
  - [ ] Task 7 (3): Add parameter to get methods to allow for more than 20 movies/tv shows to be returned
- (34) As a user, I want to be able to scroll through different categories of movies and TV shows and be presented with basic information.
  - [ ] Task 1 (5): When clicking on an item, it will send the appropriate movie ID to the details page upon page transfer
  - [ ] Task 2 (13): Improve the visual appearance and aesthetic of the Explore Tab 
  - [x] Task 3 (1): Present the average vote (rating) of the movie
  - [x] Task 4 (5): Ensure that all the movies for each category are displayed within their respective category lists
  - [x] Task 5 (3): Create a scrolling list for popular TV shows
  - [x] Task 6 (1): Create a scrolling list for now airing TV shows
  - [x] Task 7 (1): Create a scrolling list for top rated TV shows
  - [ ] Task 8 (2): Display the TV show poster on each TV show item
  - [x] Task 9 (1): Display the TV show title on each TV show item
  - [x] Task 10 (1): Display the TV show rating / vote average on each TV show item
  - [x] Task 11 (1): Display the TV show first air date on each TV show item
  - [x] Task 12 (2): Change list loop bounds (for number of items displayed) for each scrolling list
- (21) As a user, I want to be able to search movies and TV shows. 
  - [x] Task 1 (5): Implement live update results
  - [x] Task 2 (13): Implement visuals for a more aesthetic appeal for the search page
  - [x] Task 3 (5): Include informations (years, actor, etc) in result tile

## Tasks - Infrastructure & spikes
- [x] Return proper poster widgets (without any errors)
- [x] Return proper backdrops (without any errors)
- [x] Age rating, since there are some API technical aspects we have to understand / figure out
## Roles

- Valentina: Project Owner
- Mark: Scrum Master
- Jesse: Developer
- Jay: Developer
- Wilson: Developer

## Task Assignment

- Jay: API Wrapper as well as tweaking the visuals and front-end functionality
- Mark: Explore tab
- Valentina: Browse tab, ranging from the visuals to the functionality of the various genre sections and the filter option
- Jesse: Details page, ranging from displaying information to displaying reviews and implementing the trailers
- Wilson: Search tab finalizations, as well as back-end implementations / tweaking to improve the functionality and versatility of the code

## Burnup Chart

<img width="493" alt="image" src="https://user-images.githubusercontent.com/11585141/157175026-35912ac3-a20c-4249-a8aa-31cf5c25aca4.png">



## [Scrum Board](https://github.com/Valxy/CSE-115A-project/projects/3)

## Scrum Times

**Planned**

- Wednesday
  - 3:00PM (2 hours max)
  - Regular Team Meeting
- Friday
  - 3:45PM - 4:30PM (45 minutes)
  - TA Meeting

**Done**
- 02/09/2022 Wednesday 9:00PM
  - Regular Meeting - moved
- 02/11/2022 Friday 3:45PM
  - TA Meeting
- 02/13/2022 Sunday 10:00PM
  - Stand-Up Meeting - 15 minutes max.
- 02/16/2022 Wednesday 3:00PM
  - Regular Meeting
- 02/18/2022 Friday 3:45PM
  - TA Meeting
- 02/20/2022 Sunday 10:00PM
  - Stand-Up Meeting - 15 minutes max.