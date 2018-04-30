# // This file may be used for providing additional customizations to the Trestle
# // admin. It will be automatically included within all admin pages.
# //
# // For organizational purposes, you may wish to define your customizations
# // within individual partials and `require` them here.
# //
# //  e.g. //= require "trestle/custom/my_custom_js"


window.addUserToOrganization = (link) ->
  $.post $(link).data('url'),
    user_id: $('#organization-user').val()

window.addOrganizationToUser = (link) ->
  $.post $(link).data('url').replace(/0/, $('#organization-user').val())


window.addOrganizationToAddon = (link) ->
  $.post $(link).data('url'),
    organization_id: $('#organization-addon').val()

window.addCourseToAddon = (link) ->
  $.post $(link).data('url'),
    course_id: $('#addon-course').val()


window.addAddonToCourse = (link) ->
  $.post $(link).data('url').replace(/0/, $('#course-addon').val())

window.addAddonToOrganization = (link) ->
  $.post $(link).data('url').replace(/0/, $('#organization-addon').val())
