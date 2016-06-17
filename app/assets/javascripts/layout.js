// Function called when document is loaded
function searchLoad() {
  $("#layout_header_search")
    .search({
      type : 'category',
      apiSettings: {
        action: 'search',
        url: '/courses/search/?query={query}',
        method: 'get'
      },
      fields: {
        results : 'courses'
      },
      minCharacters : 2
    });
}
