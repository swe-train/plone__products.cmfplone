## Controlled Python Script "delete_confirmation"
##bind container=container
##bind context=context
##bind namespace=
##bind script=script
##bind state=state
##bind subpath=traverse_subpath
##parameters=
##title=Redirects to the regular vs link integrity confirmation page
##
from Products.CMFPlone.utils import isLinked
from Products.CMFPlone.utils import transaction_note
from Products.CMFPlone import PloneMessageFactory as _

if isLinked(context):
    # go ahead with the removal, triggering link integrity...
    # we need to copy the code from 'object_delete' here, since traversing
    # there would yield a (disallowed) GET request without the intermediate
    # confirmation page (see `object_delete.cpy`)
    parent = context.aq_inner.aq_parent
    parent.manage_delObjects(context.getId())

    message = _(u'${title} has been deleted.',
                mapping={u'title' : context.title_or_id()})
    transaction_note('Deleted %s' % context.absolute_url())

    context.plone_utils.addPortalMessage(message)
    status = 'success'
else:
    # navigate to the regular confirmation page...
    status = 'confirm'

return state.set(status=status)
