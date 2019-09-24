# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PostsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/albums/1/posts').to route_to(controller: 'posts', action: 'index', album_id: '1')
    end

    it 'routes to #new' do
      expect(get: '/albums/1/posts/new').to route_to(controller: 'posts', action: 'new', album_id: '1')
    end

    it 'routes to #show' do
      expect(get: '/albums/1/posts/1').to route_to(controller: 'posts', action: 'show', album_id: '1', id: '1')
    end

    it 'routes to #edit' do
      expect(get: '/albums/1/posts/1/edit').to route_to(controller: 'posts', action: 'edit', album_id: '1', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/albums/1/posts').to route_to(controller: 'posts', action: 'create', album_id: '1')
    end

    it 'routes to #update via PUT' do
      expect(put: '/albums/1/posts/1').to route_to(controller: 'posts', action: 'update', album_id: '1', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/albums/1/posts/1').to route_to(controller: 'posts', action: 'update', album_id: '1', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/albums/1/posts/1').to route_to(controller: 'posts', action: 'destroy', album_id: '1', id: '1')
    end
  end
end
