$(function(){
  $('.t_delete').on('click', function(){
    $('.t_overlay, .t_modalWindow').fadeIn();
    locateCenter();
  });

  $('.t_modalWindow__buttons__btn--cxl').on('click', function(){
    $('.t_overlay, .t_modalWindow').fadeOut();
  });

  function locateCenter(){
    let w = $(window).width();
    let h = $(window).height();

    let cw = $('.t_modalWindow').outerWidth();
    let ch = $('.t_modalWindow').outerHeight();

    $('.t_modalWindow').css({
      'left': ((w - cw) / 2) + 'px',
      'top': ((h- ch) / 2) + 'px'
    });
  }
});