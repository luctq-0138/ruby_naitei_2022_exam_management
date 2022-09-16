$(document).on("turbolinks:load", function () {
  jQuery(function ($) {
    window.createImageModal = function (self) {
      $("#modal-image").css("display", "block");
      $("#image-modal").attr("src", self.src);
    };
    $(".close-modal").on("click", function () {
      $("#modal-image").css("display", "none");
    });
    // $("#question_question_image").bind("change", function () {
    //   var size_in_metabytes = this.files[0].size / 1024 / 1024;
    //   if (size_in_metabytes > 5) {
    //     alert("Maximum file size is 5MB. Please choose a smaller file.");
    //   }
    // });
    const input = $("#question_question_image");
    const preview = $(".preview");
    if ($("#image-attach").length) {
      $(".preview-close").get(0).onclick = function () {
        input.get(0).value = null;
        updateImageDisplay();
      };
    }
    input.on("change", updateImageDisplay);
    const fileTypes = [
      "image/apng",
      "image/bmp",
      "image/gif",
      "image/jpeg",
      "image/pjpeg",
      "image/png",
      "image/svg+xml",
      "image/tiff",
      "image/webp",
      "image/x-icon",
    ];

    function validFileType(file) {
      return fileTypes.includes(file.type);
    }

    function updateImageDisplay() {
      while (preview.get(0).firstChild) {
        preview.get(0).removeChild(preview.get(0).firstChild);
      }

      const curFiles = Array.from(input.get(0).files);
      console.log(input.get(0).files);
      if (curFiles.length === 0) {
        preview.css("display", "none");
      } else {
        const previewClose = document.createElement("i");
        previewClose.classList.add("fa", "fa-close", "preview-close");
        previewClose.onclick = function () {
          input.get(0).value = null;
          updateImageDisplay();
        };
        preview.get(0).appendChild(previewClose);
        for (const file of curFiles) {
          const listItem = document.createElement("li");
          listItem.classList.add("preview-image-container");
          // const itemClose = document.createElement("i");
          // itemClose.classList.add("fa", "fa-close", "preview-image-close");
          // listItem.appendChild(itemClose);
          if (validFileType(file)) {
            preview.css("display", "flex");
            const image = document.createElement("img");
            image.src = URL.createObjectURL(file);
            image.setAttribute("width", "50");
            image.setAttribute("height", "50");
            listItem.appendChild(image);
          } else {
            alert(
              `File name ${file.name}: Not a valid file type. Update your selection.`
            );
          }
          preview.get(0).appendChild(listItem);
        }
      }
    }
  });
});
