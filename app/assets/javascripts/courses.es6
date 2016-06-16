class DescriptionHandler {
  constructor(description, form, url) {
    this.$description = $(description);
    this.$form = $(form);
    this.url = url;

    this.$form.hide();
  }

  showEditForm() {
    this.$description.hide();
    this.$form.show();
  }

  closeEditForm() {
    this.$description.show();
    this.$form.hide();
  }

  updateDescription() {
    $.ajax({
      method: 'PATCH',
      url: this.url,
      data: { description: this.$form.find("textarea").val() },
      success: (data) => {
        data = JSON.parse(data);
        if (data.description == null || data.description.length == 0) {
          this.$description.find("p").text(this.$form.find("textarea").attr('placeholder'));
        } else {
          this.$description.find("p").text(data.description);
        }
        this.closeEditForm();
      }
    });
  }
}


