# For more information see: http://emberjs.com/guides/routing/
Converse.Router.map ->
  @resource "rooms"

  # define routes with default settings
  # post model changes depending on what url,
  # nesting it nests templates using {{outlet}}
  @resource "room", path: '/rooms/:u1'
  @resource "room", path: '/rooms/:u1/:u2'
  @resource "room", path: '/rooms/:u1/:u2/:u3'
  @resource "room", path: '/rooms/:u1/:u2/:u3/:u4'
  @resource "room", path: '/rooms/:u1/:u2/:u3/:u4/:u5'
  @resource "room", path: '/rooms/:u1/:u2/:u3/:u4/:u5/:u6'
  @resource "room", path: '/rooms/:u1/:u2/:u3/:u4/:u5/:u6/:u7'
  @resource "room", path: '/rooms/:u1/:u2/:u3/:u4/:u5/:u6/:u7/:u8'