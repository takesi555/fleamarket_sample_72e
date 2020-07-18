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

    function buildImageboxGroup(num_unsaved) {
      let html = `<div class="imagebox__group" data-index_unsaved="${num_unsaved}" >
                    <input class="imagebox__field" 
                            type="file"
                            accept="image/*"
                            name="item[itemimages_attributes][${num_unsaved}][image]"
                            id="item_itemimages_attributes_${num_unsaved}_image">
                    </input>
                  </div>`;
      return html;
    }

  });
});
