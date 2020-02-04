// // // ドラッグ＆ドロップ実装ここは時間がかかりそうなので他の必須部分の実装が完了したら手をつけます
// 最終段階で記述が完了しなかった場合こちらは削除いたします。

// // // プレビューに挿入するHTMLの作成
// // function buildImage(loadedImageUri){
// //   var btn_wrapper = $('<div class="btn_wrapper"><div class="btn edit">編集</div><div class="btn delete">削除</div></div>');
// //       // 画像に編集・削除ボタンをつける
// //       img.append(btn_wrapper);
// //       img.find('img').attr({
// //         src: e.target.result
// //       })
// //   return html
// // };
// // // 画像を管理するための配列を定義する。
// // var files_array = [];
// // // 通常のドラッグオーバイベントを止める。
// // $('.dropzone-area').on('dragover',function(e){
// //   console.log("3")
// //     e.preventDefault();
// // });
// // // ドロップ時のイベントの作成
// // $('.dropzone-area').on('drop',function(event){
// //   event.preventDefault();
// //     // ここで、イベントによって得たファイルを配列で取り込んでいます。
// //   files = event.dataTransfer.files;
// //     // 画像のファイルを一つづつ、先ほどの画像管理用の配列に追加する。
// //   for (var i=0; i<files.length; i++) {
// //     files_array.push(files[i]);
// //     console.log(files_arry)
// //     var fileReader = new FileReader();
// //     // ファイルが読み込まれた際に、行う動作を定義する。
// //     fileReader.onload = function( event ) {
// //     // 画像のurlを取得します。
// //     var loadedImageUri = event.target.result;
// //     console.log(loadedImageUri)
// //     // 取得したURLを利用して、ビューにHTMLを挿入する。
// //     $(buildImage(loadedImageUri,)).appendTo(".dropzone-container preview").trigger("drop");
// //     };
// //     // ファイルの読み込みを行う。
// //     fileReader.readAsDataURL(files[i]);
// //   }
// // });













// let drop_file = null;
//             $('.drop-upload').on('drop', (e) => {
//               e.preventDefault();
//               // ドロップファイルを記憶
//               drop_file = e.originalEvent.dataTransfer.files[0];
              
//               // プレビュー
//               const reader = new FileReader();
//               $image_item = $(e.target).find('.preview');
//               reader.onload = (e) => {
//                 $image_item.html($('<img>').attr('src', e.target.result));
//               }
//               reader.readAsDataURL(drop_file);
//             })
            
//             // ドロップフォーム以外にドロップされたときページが画像になるのを防ぐ
//             $(document).on('drop', (e) => {
//               e.stopPropagation();
//               e.preventDefault();
//             });
//             $(document).on('dragenter', (e) => {
//               e.stopPropagation();
//               e.preventDefault();
//             });
//             $(document).on('dragover', (e) => {
//               e.stopPropagation();
//               e.preventDefault();
//             });

//             // 送信ボタンがおされたとき
//             $('form').on('submit', (e) => {
//               console.log(drop_file); // file オブジェクト
//               try {
//                 const form_data = new FormData( $(e.target).get()[0] );

//                 // ファイルが選択されてなかったらドロップファイルを送信
//                 if(!$('[type="file"]').val()) {
//                   $(e.target).find('[type="file"]').get()[0].files = e.originalEvent.dataTransfer.files;
//                   form_data.append($(e).attr('name'), drop_file);
//                 }

//                 // ここでform_data を submit したい
//               } catch(e) {}
//               return false;
//             });
// // 削除の記述
// $(document).on('click', '.delete', function() {
//   var target_image = $(this).parent().parent();
//   $.each(inputs, function(index, input){
//     if ($(this).data('image') == target_image.data('image')){
//       $(this).remove();
//       target_image.remove();
//       var num = $(this).data('image');
//       images.splice(num, 1);
//       inputs.splice(num, 1);
//       if(inputs.length == 0) {
//         $('input[type= "file"].upload-image').attr({
//           'data-image': 0
//         })
//       }
//     }
//   })
//   $('input[type= "file"].upload-image:first').attr({
//     'data-image': inputs.length
//   })
//   $.each(inputs, function(index, input) {
//     var input = $(this)
//     input.attr({
//       'data-image': index
//     })
//     $('input[type= "file"].upload-image:first').after(input)
//   })
//   // 画像が4枚以下の時は２段目のボックスが開かないようにする
//   if(images.length <= 4) {
//     dropzone2.css({
//       display: 'none'
//     })
//   }
//   if (images.length >= 5) {
//     dropzone2.css({
//       display: 'block'
//     })
//     $.each(images, function(index, image) {
//       image.attr('data-image', index);
//       preview2.append(image);
//     })
//     dropzone2.css({
//       'width': `calc(100% - (100px * ${images.length - 5}))`
//     })
//     if(images.length == 9) {
//       dropzone2.find('p').replaceWith('<i class="fa fa-camera"></i>')
//     }
//     if(images.length == 8) {
//       dropzone2.find('i').replaceWith('<p>ドラッグアンドドロップ <br>またはクリックしてファイルをアップロード</p>')
//     }
//   } else {
//     dropzone.css({
//       'display': 'block'
//     })
//     $.each(images, function(index, image) {
//       image.attr('data-image', index);
//       preview.append(image);
//     })
//     dropzone.css({
//       'width': `calc(100% - (100px * ${images.length}))`
//     })
//   }
//   if(images.length == 4) {
//     dropzone2.css({
//       'display': 'none'
//     })
//   }
//   if(images.length == 9) {
//     dropzone2.css({
//       'display': 'block'
//     })
//   }
//   if(images.length == 3) {
//     dropzone.find('i').replaceWith('<p>ドラッグアンドドロップ<br> またはクリックしてファイルをアップロード</p>')
//   }
// })
// });