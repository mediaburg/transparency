if module?.exports
  require './spec_helper'
  window.Transparency = require '../src/transparency'

describe "Transparency", ->

  it "should use a custom matcher if available", ->
    template = $ """
     <div class="container">
        <h1 data-bind="title"></h1>
        <p class="post"></p>
        <div data-bind="comments">
          <div class="comment">
            <span class="name"></span>
            <span data-bind="text"></span>
          </div>
        </div>
      </div>
      """

    data =
      title: 'Hello World'
      post:  'Hi there it is me'
      comments: [
        name: 'John'
        text: 'That rules'
      ,
        name: 'Arnold'
        text: 'Great post!'
      ]

    data_bind_matcher = (element, key) ->
      element.getAttribute('data-bind') == key

    expected_with_custom_matcher = $ """
      <div class="container">
        <h1 data-bind="title">Hello World</h1>
        <p class="post"></p>
        <div data-bind="comments">
          <div class="comment">
            <span class="name"></span>
            <span data-bind="text">That rules</span>
          </div>
          <div class="comment">
            <span class="name"></span>
            <span data-bind="text">Great post!</span>
          </div>
        </div>
      </div>
      """

    default_matcher = window.Transparency.config.matcher
    window.Transparency.config.matcher = data_bind_matcher

    template.render data
    expect(template).toBeEqual expected_with_custom_matcher
    window.Transparency.config.matcher = default_matcher
