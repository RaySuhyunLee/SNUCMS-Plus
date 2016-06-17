// Function called when document is loaded
function searchLoad() {
  $("#layout_header_search")
    .search({
      type : 'category',
      apiSettings: {
        url: '/courses/search.json?query={query}'
      },
      minCharacters : 2
    });
}
