window.addEventListener('load', function() {
  $(function() {
    function buildPreviewboxGroup(image) {
      //インプットで新規追加した画像は"unsaved"
      let html = `<div class="previewbox__group previewbox__group_unsaved">
                    <div>
                      <img src="${image}" class="previewbox__group--img">
                    </div>
                    <div class="previewbox__group--btn">
                      削除
                    </div>
                  </div>`;
      return html;
    }

    function buildImageboxGroup() {
      let html = `<div class="imagebox__group_for_new" >
                    <input class="imagebox__field" 
                            type="file"
                            accept="image/*"
                    </input>
                  </div>`;
      return html;
    }

    let previewbox_count = $('.previewbox__group').length;
    if (previewbox_count == 5) {
      $('.imagebox').css('visibility', 'hidden');
    }

    $(document).on('change', 'input[type= "file"]', function(e) {

      let reader = new FileReader();  //画像を読み込む（ファイルリーダーオブジェクトをインスタンス化）
      let file = e.target.files[0];   //inputから1つ目のfileを取得
      reader.readAsDataURL(file);     //画像ファイルのURLを取得

      reader.onload = function(e) {
        //preview-------------------------------
        //【新規・編集】previewbox__group_unsavedを後ろから追加
        $('.previewbox').append(buildPreviewboxGroup(e.target.result));

        //input-----------------------------------
        //【新規・編集】データの入ったinputタグ（DB未保存）のクラス名をimagebox__group_unsavedに変更して、imageboxの後ろから追加（非表示）
        $('.imagebox__group_for_new').removeClass('imagebox__group_for_new').addClass('imagebox__group_unsaved').appendTo('.imagebox');
        $('.imagebox__group_unsaved').hide();
        //【新規】画像追加用inputタグを追加
        $('.imagebox').prepend(buildImageboxGroup());

        //管理番号の採番---------------------------
        //（１）と（２）により編集分（＝DB保存済）のpreviweboxとinputタグのインデックス番号が揃う
        //【編集】編集分（＝DB保存済）のpreviewboxについて、changeの都度、０から採番・・・（１）
        $('.previewbox__group_saved').each(function(i) {
          $(this).attr('data-index_saved', (i));
        });
        //【編集】編集分（＝DB保存済）のinputタグについて、changeの都度、０から採番・・・（２）
        $('.imagebox__group_saved').each(function(i) {
          $(this).attr('data-index_saved', (i));
          $(this).children('.imagebox__field').attr('name', "item[itemimages_attributes][" + (i) + "][image]");
          $(this).children('.imagebox__field').attr('id', 'item_itemimages_attributes_' + (i) +'_image');
          $(this).children('.hidden-destroy').attr('name', "item[itemimages_attributes][" + (i) + "][_destroy]");
          $(this).children('.hidden-destroy').attr('id', 'item_itemimages_attributes_' + (i) +'__destroy');
        });

        //（３）と（４）により追加分（＝DB未保存）のpreviweboxとinputタグのインデックス番号が揃う
        let previewbox_saved_count = $('.previewbox__group_saved').length;
        //【新規・編集】追加分（＝DB未保存）のpreviewboxについて、changeの都度、index_savedの最終番号に続けて採番・・・（３）
        $('.previewbox__group_unsaved').each(function(i) {
          $(this).attr('data-index_unsaved', (previewbox_saved_count + i));
        });
        //【新規・編集】追加分（＝DB未保存）のinputタグについて、changeの都度、index_savedの最終番号に続けて採番・・・（４）
        $('.imagebox__group_unsaved').each(function(i) {
          $(this).attr('data-index_unsaved', (previewbox_saved_count + i));
          $(this).children('.imagebox__field_for_new').removeClass('imagebox__field_for_new').addClass('imagebox__field');
          $(this).children('.imagebox__field').attr('name', "item[itemimages_attributes][" + (previewbox_saved_count + i) + "][image]");
          $(this).children('.imagebox__field').attr('id', 'item_itemimages_attributes_' + (previewbox_saved_count + i) +'_image');
        });

        //ビューのリセット
        let previewbox_hidden_count = $('.imagebox__group_saved :checked').length;
        let previewbox_count = $('.previewbox__group').length;
        let previewbox_unhidden_count = previewbox_count - previewbox_hidden_count;
        if (previewbox_unhidden_count >=1) {
          $('.imagebox__info--comments').css('display', 'none');
        }
        if (previewbox_unhidden_count == 5) {
          $('.imagebox').css('visibility', 'hidden');
        }
      } 
    
    });
    
    $('.previewbox').on('click', '.previewbox__group--btn', function() {
        
      let targetIndex_unsaved = $(this).parent().data('index_unsaved');
      let targetIndex_saved = $(this).parent().data('index_saved');

      //【新規・編集】追加分（＝DB未保存）の場合、親要素（previewbox__group_unsaved）のインデックスと同一の親要素（プレビュー）、およびinputタグを削除する
      if (targetIndex_unsaved !== undefined){
        $('.previewbox__group_unsaved[data-index_unsaved='+targetIndex_unsaved+']').remove();
        $('.imagebox__group_unsaved[data-index_unsaved='+targetIndex_unsaved+']').remove();
      }
      
      //【編集】編集分（＝DB保存済）の場合、親要素（previewbox__group_saved）のインデックスと同一の親要素（プレビュー）を非表示、およびinputタグ（チェックボックス）の_destroyにチェックを入れる
      if (targetIndex_saved !== undefined){
        $('.previewbox__group_saved[data-index_saved='+targetIndex_saved+']').hide();
        $(`#item_itemimages_attributes_${targetIndex_saved}__destroy`).prop('checked', true);
      }
      //ビューのリセット
      let previewbox_hidden_count = $('.imagebox__group_saved :checked').length;
      let previewbox_count = $('.previewbox__group').length;
      let previewbox_unhidden_count = previewbox_count - previewbox_hidden_count;
      if (previewbox_unhidden_count <= 4) {
        $('.imagebox').css('visibility', 'visible');
      }

    });
  });
});
