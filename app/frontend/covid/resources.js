import MenuSpy from 'menuspy';

const Resources = {
  initialize() {
    $(document).on('turbolinks:load', () => {
      const submenu = $('.resource-submenu')[0];
      new MenuSpy(submenu, {
        activeClass: 'submenu-item-active'
      });
    });
  },
}

export default Resources;
