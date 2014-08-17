class ProjectBrowseBranches < Spinach::FeatureSteps
  include SharedAuthentication
  include SharedProject
  include SharedPaths

  step 'I click link "All"' do
    click_link "All"
  end

  step 'I should see "Shop" all branches list' do
    page.should have_content "Branches"
    page.should have_content "master"
  end

  step 'I click link "Protected"' do
    click_link "Protected"
  end

  step 'I should see "Shop" protected branches list' do
    within ".protected-branches-list" do
      page.should have_content "stable"
      page.should_not have_content "master"
    end
  end

  step 'project "Shop" has protected branches' do
    project = Project.find_by(name: "Shop")
    project.protected_branches.create(name: "stable")
  end

  step 'I click new branch link' do
    click_link "New branch"
  end

  step 'I submit new branch form' do
    fill_in 'branch_name', with: 'deploy_keys'
    fill_in 'ref', with: 'master'
    click_button 'Create branch'
  end

  step 'I should see new branch created' do
    within '.tree-ref-holder' do
      page.should have_content 'deploy_keys'
    end
  end

  step "I click branch 'improve/awesome' delete link" do
    within '.js-branch-improve\/awesome' do
      find('.btn-remove').click
      sleep 0.05
    end
  end

  step "I should not see branch 'improve/awesome'" do
    page.all(visible: true).should_not have_content 'improve/awesome'
  end
end
