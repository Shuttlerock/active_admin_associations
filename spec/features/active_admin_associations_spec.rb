require 'spec_helper'

describe 'ActiveAdmin Association interface', type: :feature do
  let!(:post) { create(:post) }
  let!(:tag) { create(:tag) }

  before do
    admin_login_as
    post.tags = [tag]
  end

  describe 'editing a post' do
    before do
      visit "/admin/posts/#{post.id}/edit"
    end

    it 'has correct inputs from form_columns config' do
      expect(page).to have_selector('form.post fieldset.inputs input#post_title')
      expect(page).to have_selector('form.post fieldset.inputs textarea#post_body')
      expect(page).to have_selector('form.post fieldset.inputs input#post_creator_id', visible: false)
    end

    it 'has correct inputs from active_association_form config' do
      expect(page).to have_selector('form.post fieldset.more-inputs input.my-date-picker#post_published_at')
      expect(page).to have_selector('form.post fieldset.more-inputs input#post_featured')
    end

    it 'has correct token input for post creator' do
      token_input = page.find('form.post fieldset.inputs input.token-input#post_creator_id', visible: false)
      expect(token_input['type']).to eq 'hidden'
      expect(token_input['data-model-name']).to eq 'user'
      expect(token_input['value']).to eq '1'
      expect(JSON.parse(token_input['data-pre'])).to eq [{ 'value' => 'Bill Tester', 'id' => post.creator_id }]
    end

    it 'has a form to relate new tags' do
      expect(page).to have_selector('.relationship-table#relationship-table-tags form.relate-to-form')
      expect(page).to have_selector('#relationship-table-tags form.relate-to-form input[type="hidden"]#relationship_name', visible: false)

      expect(page.find('#relationship-table-tags form.relate-to-form input#relationship_name', visible: false)['value']).to eq 'tags'

      token_input = page.find('#relationship-table-tags form.relate-to-form input.token-input#related_id', visible: false)
      expect(token_input['data-model-name']).to eq 'tag'
    end

    it 'has a table of the related tags' do
      expect(page).to have_xpath('//div[@id="relationship-table-tags"]//table[@class="index_table"]/thead//th[text()="Name"]')

      related_tag_name = page.find(:xpath,
                                   "//div[@id='relationship-table-tags']//table[@class='index_table']/tbody//tr[td[1][text()=#{tag.id}]]//td[2]").text
      expect(related_tag_name).to eq tag.name

      edit_link = page.find(:xpath, "//div[@id='relationship-table-tags']//table[@class='index_table']/tbody//tr/td[3]/a[text()='Edit']")
      expect(edit_link['href']).to match(%r{\A/admin/tags/\d+/edit})

      expect(page).to have_xpath("//div[@id='relationship-table-tags']//table[@class='index_table']/tbody//tr/td[3]/form//input[@type='submit'][@value='Unrelate']")

      unrelate_form = page.find(:xpath, "//div[@id='relationship-table-tags']//table[@class='index_table']/tbody//tr/td[3]/form[@class='button_to']")

      unrelate_url = unrelate_form['action']
      expect(unrelate_url).to match(%r{\A/admin/posts/#{post.id}/unrelate})

      query_params = unrelate_url.split('?')[1].split('&')
      expect(query_params).to match ["related_id=#{tag.id}", 'relationship_name=tags']
    end
  end

  describe 'deleting a post' do
    before do
      visit '/admin/posts'
    end

    it 'redirects back to posts index view' do
      delete_link_tag = page.find('table#index_table_posts tbody tr:first a.delete_link')
      delete_link_tag.click
      expect(page).to have_current_path '/admin/posts'
    end
  end

  describe 'editing a tag' do
    before do
      visit "/admin/tags/#{tag.id}/edit"
    end

    it 'have a table of the related posts' do
      expect(page).to have_xpath('//div[@id="relationship-table-posts"]//table[@class="index_table"]/thead//th[text()="Title"]')

      post_title_text = page.find(:xpath,
                                  "//div[@id='relationship-table-posts']//table[@class='index_table']/tbody//tr[td[1][text()=#{post.id}]]//td[2]").text
      expect(post_title_text).to eq post.title

      post_creator_name = page.find(:xpath,
                                    "//div[@id='relationship-table-posts']//table[@class='index_table']/tbody//tr[td[1][text()=#{post.id}]]//td[3]").text
      expect(post_creator_name).to eq post.creator.name
    end
  end
end
