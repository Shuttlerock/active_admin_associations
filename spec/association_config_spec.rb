require 'spec_helper'

describe ActiveAdminAssociations::AssociationConfig do
  subject do
    ActiveAdminAssociations::AssociationConfig.new do
      associations :pages, :photos
      association :tags, [:name]
      association :posts do
        fields :title, :published_at, :creator
      end
      association :videos do
        field :title
        field :description
      end
      association :products, [:name, :pid] do
        field :description
      end
    end
  end

  it 'correctly configure multiple associtions at a time' do
    expect(subject[:pages].fields).to be_blank
    expect(subject[:photos].fields).to be_blank
  end

  it 'correctly configure with a fields parameter' do
    expect(subject[:tags].fields).to eq [:name]
  end

  it 'correctly configure with a block using the fields method' do
    expect(subject[:posts].fields).to eq %i[title published_at creator]
  end

  it 'correctly configure with a block using the field method' do
    expect(subject[:videos].fields).to eq %i[title description]
  end

  it 'correctly configure with a block and the fields parameter' do
    expect(subject[:products].fields).to eq %i[name pid description]
  end
end
