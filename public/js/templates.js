(function() {
  var template = Handlebars.template, templates = Handlebars.templates = Handlebars.templates || {};
templates['header'] = template({"compiler":[7,">= 4.0.0"],"main":function(container,depth0,helpers,partials,data) {
    var helper, alias1=helpers.helperMissing, alias2="function", alias3=container.escapeExpression;

  return "<!-- NAVIGATION HEADER -->\n<div class=\"top-nav-bar\">\n\n  <div class=\"nav-left\">\n    <a href=\"/\">\n      <div class=\"menu-icon\">\n      </div>\n    </a>\n  </div>\n\n  <div class=\"nav-center\">\n    <h1>"
    + alias3(((helper = (helper = helpers.title || (depth0 != null ? depth0.title : depth0)) != null ? helper : alias1),(typeof helper === alias2 ? helper.call(depth0,{"name":"title","hash":{},"data":data}) : helper)))
    + "</h1>\n  </div>\n\n  <div class=\"nav-right\">\n    <a href=\"intro-to-me.html\">\n      <div class=\"button\">\n        ABOUT\n      </div>\n    </a>\n  </div>\n</div>\n\n<h1 class=\"small-vp-title\">"
    + alias3(((helper = (helper = helpers.title || (depth0 != null ? depth0.title : depth0)) != null ? helper : alias1),(typeof helper === alias2 ? helper.call(depth0,{"name":"title","hash":{},"data":data}) : helper)))
    + "</h1>\n";
},"useData":true});
})();