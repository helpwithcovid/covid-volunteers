
const OfficeHour = {
  initialize() {
    $(document).on('turbolinks:load', () => {
      $('body').on('click', '.oh-action', function (e) {
        OfficeHour.showCardAction(e, this);
      });
    }).on('turbolinks:before-cache', function () {
    });
  },

  showCardAction(e, that) {
    e.preventDefault();

    const isOwner = $(that).attr('x-is-owner');

    if (isOwner == 'true') {
      window.location = '/office_hours/new';
    } else {
      OfficeHour.showVolunteerCard(that);
    }

    return false;
  },

  showVolunteerCard(that) {
    const OHId = $(that).attr('x-id');
    const OHOwner = $(that).attr('x-oh-owner');
    const OHInactive = $(that).attr('x-oh-inactive');
    const when = $(that).attr('x-when');
    const canApply = $(that).attr('x-can-apply');

    if (OHInactive == 'true') {
      return;
    }

    if (canApply == 'true') {
      const headerHTML = I18n.t('when_office_hour', { when });
      const bodyHTML = I18n.t('there_is_a_slot_available_apply_below', { when, OHOwner });

      const callback = () => {
        $.ajax({
          url: `/office_hours/${OHId}/apply`,
          type: 'POST',
        });
      }

      Covid.showModal(headerHTML, bodyHTML, [ { type: 'cancel' }, { type: 'submit', text: 'Apply', callback } ], 'warning');
    } else {
      const headerHTML = I18n.t('when_office_hour', { when });
      const bodyHTML = I18n.t('there_is_a_slot_available_update_profile', { when });

      Covid.showModal(headerHTML, bodyHTML, [ { type: 'cancel', text: 'Close' } ], 'warning');
    }
  }

}

export default OfficeHour;
