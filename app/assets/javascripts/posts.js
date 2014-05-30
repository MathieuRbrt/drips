$(function(){
var $container = $('#masonry-container');
$container.imagesLoaded( function(){
  $container.masonry({
    itemSelector: '.post-masonry',
    columnWidth: 278,
    gutterWidth: 16,
    isAnimated: !Modernizr.csstransitions,
    isFitWidth: true
    });
  });
});