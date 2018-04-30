FactoryBot.define do
  factory :course do
    transient do
      organization nil
      addon nil
      with_organization true
    end
    user
    title Faker::Company.name
    description Faker::Company.bs
    image FakeFile.file

    after(:create) do |object, evaluator|
      if evaluator.with_organization
        organization = evaluator.organization || create(:organization)
        addon = evaluator.addon || create(:addon)

        create :addon_organization, organization: organization, addon: addon
        create :addon_course, course: object, addon: addon
      end
    end
  end
end
