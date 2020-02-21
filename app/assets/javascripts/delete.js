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


// -# -# アイテム詳細ボックス
// -# %section.item-box-container
// -#   %h1.item-name-box 【新品未使用】CHANEL シャネル 香水
// -#   .item-main-box
// -#     .box-photo
// -#       .box-photo__photo
// -#         = image_tag 'brand-item.jpg', alt: 'brand-item'
// -#       .box-photo__thumbnail
// -#         .box-photo__thumbnail__top
// -#           %div
// -#             = image_tag 'brand-item.jpg', alt: 'brand-item'
// -#           %div
// -#             = image_tag 'brand-item.jpg', alt: 'brand-item'
// -#           %div
// -#             = image_tag 'brand-item.jpg', alt: 'brand-item'
// -#           %div
// -#             = image_tag 'brand-item.jpg', alt: 'brand-item'
// -#           %div
// -#             = image_tag 'brand-item.jpg', alt: 'brand-item'
// -#         .box-photo__thumbnail__bottom
// -#           %div
// -#             = image_tag 'brand-item.jpg', alt: 'brand-item'
// -#           %div
// -#             = image_tag 'brand-item.jpg', alt: 'brand-item'
// -#           %div
// -#             = image_tag 'brand-item.jpg', alt: 'brand-item'
// -#           %div
// -#             = image_tag 'brand-item.jpg', alt: 'brand-item'
// -#           %div
// -#             = image_tag 'brand-item.jpg', alt: 'brand-item'
// -#     %table.box__detail-table
// -#       %tbody
// -#         %tr
// -#           %th
// -#             出品者
// -#           %td
// -#             = link_to do
// -#               -# = current_user.name
// -#               はる
// -#             %div
// -#               .user-ratings
// -#                 %i.icon-good
// -#                   = icon('fas', 'kiss-wink-heart')
// -#                 %span
// -#                 11
// -#               .user-ratings
// -#                 %i.icon-nomal
// -#                   = icon('fas', 'meh')
// -#                 %span
// -#                 14
// -#               .user-ratings
// -#                 %i.icon-bad
// -#                   = icon('fas', 'dizzy')
// -#                 %span
// -#                 1
// -#         %tr
// -#           %th
// -#             カテゴリ
// -#           %td
// -#             = link_to do
// -#               %div レディース
// -#             = link_to do
// -#               .sub-category
// -#                 = icon('fas', 'chevron-right')
// -#                 バッグ
// -#             = link_to do
// -#               .sub-sub-category
// -#                 = icon('fas', 'chevron-right')
// -#                 ショルダーバッグ
// -#         %tr
// -#           %th
// -#             ブランド
// -#           %td
// -#             = link_to do
// -#               コーチ
// -#         %tr
// -#           %th
// -#             商品の状態
// -#           %td
// -#             新品、未使用
// -#         %tr
// -#           %th
// -#             配送料の負担
// -#           %td
// -#             送料込み(出品者負担)
// -#         %tr
// -#           %th
// -#             配送の方法
// -#           %td
// -#             らくらくメルカリ便
// -#         %tr
// -#           %th
// -#             配送元地域
// -#           %td
// -#             = link_to do
// -#               未定
// -#         %tr
// -#           %th
// -#             発送日の目安
// -#           %td
// -#             1〜2日で発送
// -#   .item-price-box
// -#     %span.item-price-box.bold
// -#       ¥4,000
// -#     %span.item-price-box.tax
// -#       (税込)
// -#     %span.item-price-box.fee
// -#       送料込み
// -#   -# = link_to '購入画面に進む','#',class: 'item-buy-button '
// -#   -# = link_to '売り切れました','#',class: 'item-sold-button '
// -#   -# 売り切れじに表示するボタン部分です。現在if文での条件分岐を行なっていないためコメントアウトしています
// -#   .t_delete 
// -#     この商品を削除する  
// -#   .t_overlay
// -#   .t_modalWindow
// -#     .t_modalWindow__content
// -#       %p
// -#       %span 確認 
// -#       %p 削除すると二度と復活できません。
// -#       %p 削除する代わりに停止することもできます。
// -#       %br
// -#       %p 本当に削除しますか？
// -#     .t_modalWindow__buttons
// -#       .t_modalWindow__buttons__btn--cxl
// -#         キャンセル
// -#       = link_to "削除する",item_path, method: :delete, class: "t_modalWindow__buttons__btn"
// -#   -# ルーティングは商品詳細に飛ぶ予定です。
// -#   .item-description-box
// -#     %p.item-description-box__inner 
// -#       こちらで譲って頂きましたが別の物を購入した為出品します。
// -#       前出品者様より6-7年くらい前にいただいた商品とのことでした。
      
// -#       新品未開封なので、中身の状態確認ができていません。
      
// -#       EAU DE   PARFUM   N°5  と記載があります。
      
// -#       100mlです。
      
// -#       年数がたっていますので、中身の保証ができかねてしまうのですが、香水に詳しくて、経年劣化してるかもしれないということをご理解、ご了承頂ける方、よろしくお願いします。
// -#   .item-button-box
// -#     .item-button-box-left
// -#       .item-button-box-left__like.item-botton
// -#         = icon('far', 'heart')
// -#         いいね
// -#         ２５
// -#       .item-button-box-left__report.item-botton
// -#         = link_to do
// -#           = icon('far', 'flag')
// -#           %span 不適切な商品の報告
// -#     .item-button-box-right
// -#       = link_to do
// -#         = icon('fas', 'lock')
// -#         %span あんしん・あんぜんへの取り組み
