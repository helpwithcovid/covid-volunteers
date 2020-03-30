# Based on https://stackoverflow.com/questions/20875591/actioncontrollerinvalidauthenticitytoken-in-registrationscontrollercreate.
Rails.application.config.session_store :cookie_store, expire_after: 14.days
