FormBuilder Component
=

A component is the basic form element of FormBuilder. It is the basic building block of the form and generally represents a single question.

#####Creating a New Component
This is done by simply registering the new component in the `.run` section of the app.js file.

Simply copy the following code and modify it to suit your needs.
```
    $builder.registerComponent('COMPONENT_NAME', {
        group: 'Default OR Other',
        label: 'LABEL_ME',
        required: false,
        templateUrl: 'partials/component/tmplCOMPONENT_NAME.html',
        popoverTemplateUrl: 'partials/component/popCOMPONENT_NAME.html'
    });
```
Component templates and popover templates can be easily created by using a similar, existing component and popover as a template to structure the new one. Beware of scope variables in the view that must be linked properly in order for everything to function properly.

#####Component Components
A component has the following main attributes:

- Group - which tab it will be displayed in, in the editor
- Label - what thd default label/question name will be
- Description - A description or short text that will go below the input in the component.
- Placeholder - The placeholder for text inputs or other inputs NOT to be confused with default value.
- Required - whether response to component is required
- options - array of options in the component, used for drop downs, checklists, etc
- arrayToText - whether response should be in array format, used for checklists and other components where response needs to be divided into an array.
- template - HTML that contains the HTML for the component
- templateUrl - HTML file that contains the HTML for the component - use template OR templateUrl, not both
- popoverTemplateUrl - that contains the HTML for the component popover in the editor view and allows user that builds forms to make configure the component.