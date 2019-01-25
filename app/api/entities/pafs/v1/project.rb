class Entities::Pafs::V1::Project
  def self.present(project)
    project.serializable_hash(
      except: [
        :id,
        :project_location,
        :project_location_zoom_level
      ],
      include: [
        {
          areas: {
            except: [
              :id,
              :area_id,
              :project_id,
              :parent_id,
              :created_at,
              :updated_at
            ],
            include: [
              {
                parent: {
                  except: [
                    :id,
                    :parent_id,
                    :created_at,
                    :updated_at,
                  ]
                }
              } 
            ]
          }
        },
        {
          funding_values: {
            except: [
              :id,
              :project_id,
              :created_at,
              :updated_at
            ]
          }
        },
        {
          flood_protection_outcomes: {
            except: [
              :id,
              :project_id,
              :created_at,
              :updated_at
            ]
          }
        },
        {
          coastal_erosion_protection_outcomes: {
            except: [
              :id,
              :project_id,
              :created_at,
              :updated_at
            ]
          }
        },
        {
          state: {
            except: [
              :id,
              :project_id
            ]
          }
        }
      ]
    )
  end
end
