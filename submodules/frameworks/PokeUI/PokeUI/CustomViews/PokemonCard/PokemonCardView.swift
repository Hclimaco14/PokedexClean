//
//  PokemonCardView.swift
//  PokeUI
//
//  Created by Hector Climaco on 30/07/26.
//

import SwiftUI
import PokeSharedUI
import PokeCore

struct PokemonCardView: View {
    
    struct PokemonCardViewStyle{
        var title:Font = Font.system(size: 16).bold()
        var subtitle:Font = Font.system(size: 14).bold()
        var body:Font = Font.system(size: 10)
    }
    
    @ObservedObject var viewModel: PokemonCardViewModel
    
    var style: PokemonCardViewStyle
    
    var body: some View {
        GeometryReader { proxy in
            VStack {
                name
                
                imagePokemon(size: proxy.size)
                
            }
            .padding(8)
            .background(viewModel.color.opacity(0.7))
            .clipShape(RoundedRectangle(cornerRadius: 16))
            
        }
    }
    
    var name: some View{
        HStack(alignment: .top){
            Text(viewModel.namePokemon)
                .font(style.title)
                .foregroundStyle(Color(.white))
            
            Spacer()
            
            Text(viewModel.idPokemon)
                .font(style.subtitle)
                .foregroundStyle(Color(.white))
                
        }
    }
    
    var types: some View{
        VStack (alignment: .leading,spacing: 8){
            ForEach(viewModel.attributes, id: \.self){ type in
                VStack{
                    Text(type.capitalized)
                        .font(style.body)
                        .font(.subheadline)
                        .foregroundStyle(Color.white)
                        .padding(8)
                }.background(Color.gray.opacity(0.5))
                .clipShape(RoundedRectangle(cornerRadius: 16))
                   
            }
        }
    }
    
    func imagePokemon(size: CGSize) -> some View {
        HStack(alignment: .top ){
            types
            Spacer()
            if let image = viewModel.image{
                ZStack{
                    image
                        .frame(width: ((size.width/2) - 8) ,height: ((size.width/2) - 8))
                        .aspectRatio(contentMode: .fit)
                        .padding(.trailing,-16)
                        .padding(.bottom,-16)
                    
                    Image(asset: .pokeballBackGround)
                        .renderingMode(.template)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: (size.width/2),height: (size.width/2))
                        .foregroundStyle(viewModel.color)
                        .zIndex(-1)
                        .padding(.trailing,-16)
                        .padding(.bottom,-16)
                        
                }
            }
        }
    }
}

struct PokemonCardView_Previews: PreviewProvider {
    static var previews: some View {
        let pokemonJson = """
                {
                  "abilities": [
                    {
                      "ability": {
                        "name": "keen-eye",
                        "url": "https://pokeapi.co/api/v2/ability/51/"
                      },
                      "is_hidden": false,
                      "slot": 1
                    },
                    {
                      "ability": {
                        "name": "sniper",
                        "url": "https://pokeapi.co/api/v2/ability/97/"
                      },
                      "is_hidden": true,
                      "slot": 3
                    }
                  ],
                  "base_experience": 52,
                  "cries": {
                    "latest": "https://raw.githubusercontent.com/PokeAPI/cries/main/cries/pokemon/latest/21.ogg",
                    "legacy": "https://raw.githubusercontent.com/PokeAPI/cries/main/cries/pokemon/legacy/21.ogg"
                  },
                  "forms": [
                    {
                      "name": "spearow",
                      "url": "https://pokeapi.co/api/v2/pokemon-form/21/"
                    }
                  ],
                  "game_indices": [
                        {
                      "game_index": 5,
                      "version": {
                        "name": "red",
                        "url": "https://pokeapi.co/api/v2/version/1/"
                      }
                    },
                    {
                      "game_index": 5,
                      "version": {
                        "name": "blue",
                        "url": "https://pokeapi.co/api/v2/version/2/"
                      }
                    }
                  ],
                  "height": 3,
                  "held_items": [
                    {
                      "item": {
                        "name": "sharp-beak",
                        "url": "https://pokeapi.co/api/v2/item/221/"
                      },
                      "version_details": [
                        {
                          "rarity": 5,
                          "version": {
                            "name": "ultra-moon",
                            "url": "https://pokeapi.co/api/v2/version/30/"
                          }
                        },
                        {
                          "rarity": 100,
                          "version": {
                            "name": "xd",
                            "url": "https://pokeapi.co/api/v2/version/20/"
                          }
                        }
                      ]
                    }
                  ],
                  "id": 21,
                  "is_default": true,
                  "location_area_encounters": "https://pokeapi.co/api/v2/pokemon/21/encounters",
                  "moves": [
                        {
                      "move": {
                        "name": "razor-wind",
                        "url": "https://pokeapi.co/api/v2/move/13/"
                      },
                      "version_group_details": [
                                {
                          "level_learned_at": 0,
                          "move_learn_method": {
                            "name": "machine",
                            "url": "https://pokeapi.co/api/v2/move-learn-method/4/"
                          },
                          "order": null,
                          "version_group": {
                            "name": "red-blue",
                            "url": "https://pokeapi.co/api/v2/version-group/1/"
                          }
                        }
                      ]
                    },
                    {
                      "move": {
                        "name": "wing-attack",
                        "url": "https://pokeapi.co/api/v2/move/17/"
                      },
                      "version_group_details": [
                        {
                          "level_learned_at": 18,
                          "move_learn_method": {
                            "name": "level-up",
                            "url": "https://pokeapi.co/api/v2/move-learn-method/1/"
                          },
                          "order": null,
                          "version_group": {
                            "name": "brilliant-diamond-shining-pearl",
                            "url": "https://pokeapi.co/api/v2/version-group/23/"
                          }
                        }
                      ]
                    }
                  ],
                  "name": "spearow",
                  "order": 30,
                  "past_abilities": [
                    {
                      "abilities": [
                        {
                          "ability": null,
                          "is_hidden": true,
                          "slot": 3
                        }
                      ],
                      "generation": {
                        "name": "generation-iv",
                        "url": "https://pokeapi.co/api/v2/generation/4/"
                      }
                    }
                  ],
                  "past_stats": [
                    {
                      "generation": {
                        "name": "generation-i",
                        "url": "https://pokeapi.co/api/v2/generation/1/"
                      },
                      "stats": [
                        {
                          "base_stat": 31,
                          "effort": 0,
                          "stat": {
                            "name": "special",
                            "url": "https://pokeapi.co/api/v2/stat/9/"
                          }
                        }
                      ]
                    }
                  ],
                  "past_types": [],
                  "species": {
                    "name": "spearow",
                    "url": "https://pokeapi.co/api/v2/pokemon-species/21/"
                  },
                  "sprites": {
                    "back_default": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/21.png",
                    "back_female": null,
                    "back_shiny": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/21.png",
                    "back_shiny_female": null,
                    "front_default": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/21.png",
                    "front_female": null,
                    "front_shiny": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/21.png",
                    "front_shiny_female": null,
                    "other": {
                      "dream_world": {
                        "front_default": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/dream-world/21.svg",
                        "front_female": null
                      },
                      "home": {
                        "front_default": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/21.png",
                        "front_female": null,
                        "front_shiny": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/shiny/21.png",
                        "front_shiny_female": null
                      },
                      "official-artwork": {
                        "front_default": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/21.png",
                        "front_shiny": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/shiny/21.png"
                      },
                      "showdown": {
                        "back_default": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/showdown/back/21.gif",
                        "back_female": null,
                        "back_shiny": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/showdown/back/shiny/21.gif",
                        "back_shiny_female": null,
                        "front_default": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/showdown/21.gif",
                        "front_female": null,
                        "front_shiny": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/showdown/shiny/21.gif",
                        "front_shiny_female": null
                      }
                    },
                    "versions": {
                      "generation-i": {
                        "red-blue": {
                          "back_default": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-i/red-blue/back/21.png",
                          "back_gray": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-i/red-blue/back/gray/21.png",
                          "back_transparent": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-i/red-blue/transparent/back/21.png",
                          "front_default": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-i/red-blue/21.png",
                          "front_gray": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-i/red-blue/gray/21.png",
                          "front_transparent": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-i/red-blue/transparent/21.png"
                        },
                        "yellow": {
                          "back_default": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-i/yellow/back/21.png",
                          "back_gray": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-i/yellow/back/gray/21.png",
                          "back_transparent": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-i/yellow/transparent/back/21.png",
                          "front_default": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-i/yellow/21.png",
                          "front_gray": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-i/yellow/gray/21.png",
                          "front_transparent": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-i/yellow/transparent/21.png"
                        }
                      },
                      "generation-ii": {
                        "crystal": {
                          "back_default": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-ii/crystal/back/21.png",
                          "back_shiny": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-ii/crystal/back/shiny/21.png",
                          "back_shiny_transparent": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-ii/crystal/transparent/back/shiny/21.png",
                          "back_transparent": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-ii/crystal/transparent/back/21.png",
                          "front_default": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-ii/crystal/21.png",
                          "front_shiny": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-ii/crystal/shiny/21.png",
                          "front_shiny_transparent": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-ii/crystal/transparent/shiny/21.png",
                          "front_transparent": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-ii/crystal/transparent/21.png"
                        },
                        "gold": {
                          "back_default": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-ii/gold/back/21.png",
                          "back_shiny": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-ii/gold/back/shiny/21.png",
                          "front_default": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-ii/gold/21.png",
                          "front_shiny": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-ii/gold/shiny/21.png",
                          "front_transparent": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-ii/gold/transparent/21.png"
                        },
                        "silver": {
                          "back_default": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-ii/silver/back/21.png",
                          "back_shiny": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-ii/silver/back/shiny/21.png",
                          "front_default": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-ii/silver/21.png",
                          "front_shiny": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-ii/silver/shiny/21.png",
                          "front_transparent": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-ii/silver/transparent/21.png"
                        }
                      }
                    }
                  },
                  "stats": [
                    {
                      "base_stat": 40,
                      "effort": 0,
                      "stat": {
                        "name": "hp",
                        "url": "https://pokeapi.co/api/v2/stat/1/"
                      }
                    },
                    {
                      "base_stat": 60,
                      "effort": 0,
                      "stat": {
                        "name": "attack",
                        "url": "https://pokeapi.co/api/v2/stat/2/"
                      }
                    },
                    {
                      "base_stat": 30,
                      "effort": 0,
                      "stat": {
                        "name": "defense",
                        "url": "https://pokeapi.co/api/v2/stat/3/"
                      }
                    },
                    {
                      "base_stat": 31,
                      "effort": 0,
                      "stat": {
                        "name": "special-attack",
                        "url": "https://pokeapi.co/api/v2/stat/4/"
                      }
                    },
                    {
                      "base_stat": 31,
                      "effort": 0,
                      "stat": {
                        "name": "special-defense",
                        "url": "https://pokeapi.co/api/v2/stat/5/"
                      }
                    },
                    {
                      "base_stat": 70,
                      "effort": 1,
                      "stat": {
                        "name": "speed",
                        "url": "https://pokeapi.co/api/v2/stat/6/"
                      }
                    }
                  ],
                  "types": [
                    {
                      "slot": 1,
                      "type": {
                        "name": "normal",
                        "url": "https://pokeapi.co/api/v2/type/1/"
                      }
                    },
                    {
                      "slot": 2,
                      "type": {
                        "name": "flying",
                        "url": "https://pokeapi.co/api/v2/type/3/"
                      }
                    }
                  ],
                  "weight": 20
                }
            """
        
        let data = Data(pokemonJson.utf8)
        let decoder = JSONDecoder()
        var pokemonRes: PokemonDetailResponse?
        
        do{
            if let pokemonResponse = try? decoder.decode(PokemonDetailResponse.self, from: data) {
                pokemonRes = pokemonResponse
            }
        }
        return VStack{
            
            HStack{
                PokemonCardView(viewModel: PokemonCardViewModel(pokemonDetail: pokemonRes), style: .init())
                
                PokemonCardView(viewModel: PokemonCardViewModel(pokemonDetail: pokemonRes),style: .init())
                
            }.padding(.horizontal)
            
            
            Spacer()
        }
    }
}
