$(function() {
  $('.sidebar-nav .category-toggle').on('click', function(e) {
    e.preventDefault();
    var $this = $(this);
    $this.parent().find('.sub-category').toggle();
  });

  var searchLimit = 5;

  var search = new Bloodhound({
    datumTokenizer: Bloodhound.tokenizers.obj.whitespace('query'),
    queryTokenizer: Bloodhound.tokenizers.whitespace,
    remote: {
      url: '/search/',
      prepare: function(query, settings) {
        var data = {
          "q": query,
          "limit": searchLimit,
        };
        console.log(query);
        //settingsはjQueryの$.ajaxへ渡すオプション。
        settings.type = 'GET';
        settings.contentType = 'application/json';
        settings.xhrFields = {
          withCredentials: false
        };
        settings.data = data;
        return settings;
      },
      transform: function(res) {
        console.log(res);
        return res;
      },
    },
    rateLimitWait: 1000
  });

  $('.typeahead').typeahead({
    minLength: 3
  }, {
    name: 'search',
    display: 'query',
    source: search,
    limit: searchLimit * 2,
    templates: {
      notFound: [
        '<div class="empty-message">',
          '見つかりません😇',
        '</div>'
      ].join('\n'),
      suggestion: Handlebars.compile('<div><a href="{{path}}">{{name}}</a></div>')
    }
  });

});
