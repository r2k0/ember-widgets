Ember.Widgets.Color = Ember.Object.extend
  init: (red, green, blue) ->
    @red = red
    @green = green
    @blue = blue
  red: 0
  green: 0
  blue: 0
  rgbString: (->
    "rgb(#{@get('red')}, #{@get('green')}, #{@get('blue')})")
  .property('red', 'green', 'blue')

Ember.Widgets.ColorPicker = Ember.View.extend
  templateName: 'color_picker'
  classNames: ['color-picker']
  selectedColor: new Ember.Widgets.Color(40, 90, 200)
  colorPickerPlacement: 'right'
  selectedColorString: (->
    @get('selectedColor').get('rgbString'))
  .property('selectedColor')
  usePopOver: yes

  showPalette: (event) ->
    if @usePopOver
      if @get('popover.isShowing')
        @get('popover').hide()
        @set 'popover', null
      else
        popover = Ember.Widgets.PopoverComponent.popup
          placement: @get('colorPickerPlacement')
          targetElement: event.target
          contentViewClass: Ember.Widgets.ColorPickerPalette
          parentView: this
        popover.classNames.push('color-picker-popover')
        @set 'popover', popover

Ember.Widgets.ColorPickerCell = Ember.View.extend Ember.Widgets.StyleBindingsMixin,
  attributeBindings: ['color']
  styleBindings:  'content:background-color'
  color: new Ember.Widgets.Color(0, 0, 0)
  content: (() ->
    @get('color').get('rgbString'))
  .property('color')

Ember.Widgets.ColorPickerSelectionCell = Ember.Widgets.ColorPickerCell.extend
  mouseDown: (event) ->
    @set 'parentView.selectedColor', @get('color')

Ember.Widgets.ColorPickerSelectedCell = Ember.Widgets.ColorPickerCell.extend
  click: (event) ->
    event.preventDefault()
    this.get('parentView').showPalette(event)

Ember.Widgets.ColorPickerPalette = Ember.Component.extend
  templateName: 'color_picker_palette'

  colorRows:
    [
      [ new Ember.Widgets.Color(0, 0, 0),
        new Ember.Widgets.Color(67, 67, 67),
        new Ember.Widgets.Color(102, 102, 102),
        new Ember.Widgets.Color(183, 183, 183),
        new Ember.Widgets.Color(204, 204, 204),
        new Ember.Widgets.Color(217, 217, 217),
        new Ember.Widgets.Color(239, 239, 239),
        new Ember.Widgets.Color(243, 243, 243),
        new Ember.Widgets.Color(255, 255, 255)
      ],
      [
        new Ember.Widgets.Color(152, 0, 0),
        new Ember.Widgets.Color(255, 0, 0),
        new Ember.Widgets.Color(255, 153, 0),
        new Ember.Widgets.Color(255, 255, 0),
        new Ember.Widgets.Color(0, 255, 0),
        new Ember.Widgets.Color(0, 255, 255),
        new Ember.Widgets.Color(0, 0, 255),
        new Ember.Widgets.Color(153, 0, 255),
        new Ember.Widgets.Color(255, 0, 255)
      ]
    ]
