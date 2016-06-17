// Function called when document is loaded
function searchLoad() {
  $("#layout_header_search")
    .search({
      apiSettings: {
        action: 'search',
        url: '/courses/search/?query={query}',
        method: 'get'
      },
      minCharacters : 2
    });
}
