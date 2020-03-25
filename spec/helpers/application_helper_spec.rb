require 'rails_helper'

path = 'http://localhost:3000/projects?skills=Biology,Software&project_types=Track%20the%20outbreak,Reduce%20spread&filters_open=true'

RSpec.describe ApplicationHelper do
  let(:request) { double('request', fullpath: path) }
  before  { allow(helper).to receive(:request).and_return(request) }

  it 'gets query params' do
    params = get_query_params
    desired_params = {'skills'=>['Biology', 'Software'], 'project_types'=>['Track the outbreak', 'Reduce spread'], 'filters_open'=>['true']}
    assert params.eql? desired_params
  end

  it 'gets filters if present' do
    skills_filters = get_query_params['skills']
    assert skills_filters.eql? ['Biology', 'Software']
  end

  it 'gets filters if not present' do
    skills_filters = get_query_params['not_a_filter']
    assert skills_filters.eql? []
  end

  it 'toggles a filter on' do
    toggled_on = toggle_filter('skills', 'JellyFishing')
    desired_params = {'skills'=>['Biology', 'Software', 'JellyFishing'], 'project_types'=>['Track the outbreak', 'Reduce spread'], 'filters_open'=>['true']}
    assert toggled_on.eql? desired_params
  end

  it 'toggles a filter off' do
    toggled_on = toggle_filter('skills', 'Biology')
    desired_params = {'skills'=>['Software'], 'project_types'=>['Track the outbreak', 'Reduce spread'], 'filters_open'=>['true']}
    assert toggled_on.eql? desired_params
  end

  it 'builds a query string' do
    querystring = build_query_string(toggle_filter('skills', 'Software'))
    desired_qs = 'skills=Biology&project_types=Track+the+outbreak,Reduce+spread&filters_open=true'
    assert querystring.eql? desired_qs
  end

  it 'clears a filter' do
    querystring = build_query_string(toggle_filter('skills', 'Software'))
    desired_qs = 'skills=Biology&project_types=Track+the+outbreak,Reduce+spread&filters_open=true'
    assert querystring.eql? desired_qs
  end
end
