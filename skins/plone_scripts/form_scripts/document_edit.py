## Script (Python) "document_edit"
##parameters=text_format, text, file='', SafetyBelt='', choice=' Change ', title='', description='', id=''
##title=Edit a document

filename=getattr(file, 'filename', '')
if file and filename and context.isIDAutoGenerated(id):
    id=filename[max( filename.rfind('/')
                   , filename.rfind('\\')
                   , filename.rfind(':') )+1:]
if file and filename:
    file.seek(0)
    
new_context = context.portal_factory.doCreate(context, id)
new_context.edit( text_format
                , text
                , file
                , safety_belt=SafetyBelt )
new_context.plone_utils.contentEdit( context
                                   , id=id
                                   , title=title
                                   , description=description )
return ('success', new_context, {'portal_status_message':context.REQUEST.get('portal_status_message', 'Document changes saved.')})
