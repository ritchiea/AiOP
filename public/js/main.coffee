@app = angular.module('oracle', [])

@app.controller 'ctrl', ['$scope', '$timeout', '$http', ($scope, $timeout, $http) ->

  $scope.distance = '.1'

  getPosts = () ->
    $scope.showLoader = true
    $http.get('./fetch', {params: { distance: $scope.distance } }).success((data) ->
      $scope.posts = data
      $scope.showLoader = false
    )

  pollPosts = () ->
    getPosts()
    $timeout pollPosts, 30000

  pollPosts()

  $scope.refresh = () ->
    getPosts()

]
