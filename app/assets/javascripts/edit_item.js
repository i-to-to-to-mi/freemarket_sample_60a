$(window).on("turbolinks:load", function() {

  var dropzone = $(".dropzone-area");
  var dropzone2 = $(".dropzone-area2");
  var input_area = $(".input-area");
  var preview = $("#preview");
  var preview2 = $("#preview2");

  // 登録済画像と新規追加画像を全て格納する配列（ビュー用）
  var images = [];
  // 登録済画像データだけの配列（DB用）
  var registered_images_ids =[];
  // 新規追加画像データだけの配列（DB用）
  var new_image_files = [];
  
   // 登録済画像のプレビュー表示
  gon.images.forEach(function(image, index){
    var img = $(`<div class= "img_view"><img></div>`);
    // カスタムデータ属性を付与
    img.data("image", index)

    var btn_wrapper = $('<div class="btn_wrapper"><div class="btn edit">編集</div><div class="btn delete">削除</div></div>');

    // 画像に編集・削除ボタンをつける
    img.append(btn_wrapper);

    binary_data = gon.images_binary_datas[index]
    
    // 表示するビューにバイナリーデータを付与
    img.find("img").attr({
      src: "data:image/jpeg;base64," + binary_data
    });

    // 登録済画像のビューをimagesに格納
    images.push(img)
    registered_images_ids.push(image.id)

    if(images.length <= 4) {
      $('#preview').empty();
      $.each(images, function(index, image) {
        image.attr('data-image', index);
        image.data('image', index);
        preview.append(image);
      })
      dropzone.css({
        'width': `calc(100% - ${images.length}))`
      })
      dropzone2.css({
        display: 'none'
      })
    } else if(images.length >= 6) {
      dropzone2.css({
        'display': 'block'
      })
      dropzone.css({
        'display': 'none'
      })
      preview2.empty();
      // // 配列から６枚目以降の画像を抽出
      var pickup_images = images.slice(5);
      $.each(pickup_images, function(index, image) {
        image.attr('data-image', index + 5);
        preview2.append(image);
        dropzone2.css({
          width: `calc(100% - (100px * ${images.length - 5}))`
        });
      });
      if(images.length == 9) {
        dropzone2.find('p').replaceWith('<i class="fa fa-camera"></i>')
      } 
    } else {
        $('#preview').empty();
        $.each(images, function(index, image) {
          image.attr('data-image', index);
          preview.append(image);
        })
        dropzone.css({
          display: 'none'
        })
        dropzone2.css({
          'display': 'block'
        })
    }
    if(images.length == 4) {
      dropzone.find('p').replaceWith('<i class="fa fa-camera"></i>')
      }
    if(images.length == 10) {
      dropzone2.css({
        display: 'none'
      })
      return;
    }
    
  var new_image = $(
    `<input multiple= "multiple" name="images[src][]" class="upload-image${images.length}" data-image= ${images.length} type="file" id="upload-image" style="display:none;">`
  );
  input_area.append(new_image);

  });

  // １段目の画像を新しく追加する場合
  $(dropzone).on('change', 'input[type= "file"].upload-image',function(event) {
    event.preventDefault();
    var file = $(this).prop("files")[0];
    new_image_files.push(file)
    var reader = new FileReader();
    var img = $(`<div class= "img_view"><img></div>`);
    reader.onload = function(e) {
      var btn_wrapper = $('<div class="btn_wrapper"><div class="btn edit">編集</div><div class="btn delete">削除</div></div>');

      // 画像に編集・削除ボタンをつける
      img.append(btn_wrapper);
      img.find("img").attr({
        src: e.target.result
      });
    };

    reader.readAsDataURL(file);
    images.push(img);

      $('#preview').empty();
      $.each(images, function(index, image) {
        image.data('image', index);
        preview.append(image);
      })
      dropzone.css({
        'width': `calc(100% - ${images.length}))`
      })
      dropzone2.css({
        display: 'none'
      })

      if(images.length > 4) {
        dropzone2.css({
        display: 'block'
        })
        dropzone.css({
          display: 'none'
        })
        return;
      }

      if(images.length == 4) {
        dropzone.find('p').replaceWith('<i class="fa fa-camera"></i>')
      }
    
    var new_image = $(
      `<input multiple= "multiple" name="images[src][]" class="upload-image${images.length}" data-image= ${images.length} type="file" id="upload-image" style="display:none;">`
    );
    input_area.append(new_image);
  });

// ２段目の画像を新しく追加する場合
  $(dropzone2).on('change', 'input[type= "file"].upload-image2',function(event) {
    event.preventDefault();
    var file = $(this).prop("files")[0];
    new_image_files.push(file)
    var reader = new FileReader();
    var img = $(`<div class= "img_view"><img></div>`);
    reader.onload = function(e) {
      var btn_wrapper = $('<div class="btn_wrapper"><div class="btn edit">編集</div><div class="btn delete">削除</div></div>');

      // 画像に編集・削除ボタンをつける
      img.append(btn_wrapper);
      img.find("img").attr({
        src: e.target.result
      });
    };

    reader.readAsDataURL(file);
    images.push(img);

      dropzone2.css({
        'display': 'block'
      })
      dropzone.css({
        'display': 'none'
      })
      $('#preview').empty();
      $.each(images, function(index, image) {
        image.attr('data-image', index);
        if(index > 4) {
          return true;
        }
        preview.append(image);
        dropzone2.css({
          width: `calc(100% - (100px * ${images.length - 5}))`
        })
      })
      $('#preview2').empty();
      $.each(images, function(index, image) {
        image.attr('data-image', index);
        if(index <= 4) {
          return true;
        }
        preview2.append(image);
      });



      if(images.length == 9) {
        dropzone2.find('p').replaceWith('<i class="fa fa-camera"></i>')
      } 
      if(images.length == 10) {
        dropzone2.css({
          display: 'none'
        })
        return;
      }
    

    var new_image = $(
      `<input multiple= "multiple" name="images[src][]" class="upload-image${images.length}" data-image= ${images.length} type="file" id="upload-image" style="display:none;">`
    );
    input_area.append(new_image);
  });


  // 削除ボタン

  $(document).on('click', '.delete', function() {
    // 削除ボタンを押した画像を取得
    var target_image = $(this).parent().parent();
    
    // 削除画像のdata-image番号を取得
    var target_image_num = target_image.data('image');

    // 対象の画像をビュー上で削除
    target_image.remove();

    // 対象の画像を削除した新たな配列を生成
    images.splice(target_image_num, 1);

    // target_image_numが登録済画像の数以下の場合は登録済画像データの配列から削除、それより大きい場合は新たに追加した画像データの配列から削除
    if (target_image_num < registered_images_ids.length) {
      registered_images_ids.splice(target_image_num, 1);
    } else {
      new_image_files.splice((target_image_num - registered_images_ids.length), 1);
    }

    if(images.length == 0) {
      $('input[type= "file"].upload-image').attr({
        'data-image': 0
      })
    }


    
    if(images.length <= 4) {
      $('#preview').empty();
      $.each(images, function(index, image) {
        image.data('image', index);
        preview.append(image);
      })
      dropzone.css({
        'width': `calc(100% - ${images.length}))`
      })
      dropzone2.css({
        display: 'none'
      })
    } else if(images.length >= 6) {
      dropzone2.css({
        'display': 'block'
      })
      dropzone.css({
        'display': 'none'
      })
      preview2.empty();
      // 配列から６枚目以降の画像を抽出
      var pickup_images = images.slice(5);
      $.each(pickup_images, function(index, image) {
        image.data("image", index + 5);
        preview2.append(image);
        dropzone2.css({
          width: `calc(100% - (100px * ${images.length - 5}))`
        });
      });
      if(images.length == 9) {
        dropzone2.find('p').replaceWith('<i class="fa fa-camera"></i>')
      } 
    } else {
      
        $('#preview').empty();
        $.each(images, function(index, image) {
          image.attr('data-image', index);
          preview.append(image);
        })
        dropzone.css({
          display: 'none'
        })
      }
      if(images.length == 4) {
        dropzone.find('p').replaceWith('<i class="fa fa-camera"></i>')
      }
      if(images.length == 10) {
        dropzone2.css({
          display: 'none'
        })
        return;
      }
  })


  $('.edit__item').on('submit', function(e){
    // 通常のsubmitイベントを止める
    e.preventDefault();
    // images以外のform情報をformDataに追加
    var formData = new FormData($(this).get(0));

    // 登録済画像が残っていない場合は便宜的に0を入れる
    if (registered_images_ids.length == 0) {
      formData.append("registered_images_ids[ids][]", 0)
    // 登録済画像で、まだ残っている画像があればidをformDataに追加していく
    } else {
      registered_images_ids.forEach(function(registered_image){
        formData.append("registered_images_ids[ids][]", registered_image)
      });
    }

    // 新しく追加したimagesがない場合は便宜的に空の文字列を入れる
    if (new_image_files.length == 0) {
      formData.append("new_images[images][]", " ")
    // 新しく追加したimagesがある場合はformDataに追加する
    } else {
      new_image_files.forEach(function(file){
        formData.append("new_images[images][]", file)
      });
    }

    $.ajax({
      url:         '/items/' + gon.item.id,
      type:        "PATCH",
      data:        formData,
      contentType: false,
      processData: false,
    })
  });
});
