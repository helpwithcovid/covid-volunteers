import MenuSpy from 'menuspy';

const Resources = {
  initialize() {
    let ms = null;
    $(document).on('turbolinks:load', () => {
      if ($('.resource-submenu').length > 0) {
        ms = new MenuSpy('.resource-submenu', {
          activeClass: 'submenu-item-active',
          enableLocationHash: false,
        });
      }
    }).on('turbolinks:before-cache', function () {
      if (ms) {
        ms.destroy();
        ms = null;
      }
    });
  },
}

export default Resources;
