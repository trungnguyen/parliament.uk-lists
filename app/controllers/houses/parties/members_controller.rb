module Houses
  module Parties
    class MembersController < ApplicationController
      before_action :data_check, :build_request

      ROUTE_MAP = {
        index:           proc { |params| Parliament::Utils::Helpers::ParliamentHelper.parliament_request.house_party_members.set_url_params({house_id: params[:house_id], party_id: params[:party_id] }) },
        a_to_z_current:  proc { |params| Parliament::Utils::Helpers::ParliamentHelper.parliament_request.house_party_current_members_a_to_z.set_url_params({ house_id: params[:house_id], party_id: params[:party_id] }) },
        current:         proc { |params| Parliament::Utils::Helpers::ParliamentHelper.parliament_request.house_party_current_members.set_url_params({ house_id: params[:house_id], party_id: params[:party_id] }) },
        letters:         proc { |params| Parliament::Utils::Helpers::ParliamentHelper.parliament_request.house_party_members_by_initial.set_url_params({ house_id: params[:house_id], party_id: params[:party_id], initial: params[:letter] }) },
        current_letters: proc { |params| Parliament::Utils::Helpers::ParliamentHelper.parliament_request.house_party_current_members_by_initial.set_url_params({ house_id: params[:house_id], party_id: params[:party_id], initial: params[:letter]  }) },
        a_to_z:          proc { |params| Parliament::Utils::Helpers::ParliamentHelper.parliament_request.house_party_members_a_to_z.set_url_params({ house_id: params[:house_id], party_id: params[:party_id] }) }
      }.freeze

      def index
        @house, @party, @people, @letters = Parliament::Utils::Helpers::RequestHelper.filter_response_data(
          @request,
          'http://id.ukpds.org/schema/House',
          'http://id.ukpds.org/schema/Party',
          'http://id.ukpds.org/schema/Person',
          ::Grom::Node::BLANK
        )
        @house = @house.first
        @party = @party.first
        @people = @people.sort_by(:sort_name)
        @letters = @letters.map(&:value)
        @current_person_type, @other_person_type = Parliament::Utils::Helpers::HousesHelper.person_type_string(@house)
      end

      def letters
        @house, @party, @people, @letters = Parliament::Utils::Helpers::RequestHelper.filter_response_data(
          @request,
          'http://id.ukpds.org/schema/House',
          'http://id.ukpds.org/schema/Party',
          'http://id.ukpds.org/schema/Person',
          ::Grom::Node::BLANK
        )
        @house = @house.first
        @party = @party.first
        @people = @people.sort_by(:sort_name)
        @letters = @letters.map(&:value)
        @current_person_type, @other_person_type = Parliament::Utils::Helpers::HousesHelper.person_type_string(@house)
      end

      def current
        @house, @party, @people, @letters = Parliament::Utils::Helpers::RequestHelper.filter_response_data(
          @request,
          'http://id.ukpds.org/schema/House',
          'http://id.ukpds.org/schema/Party',
          'http://id.ukpds.org/schema/Person',
          ::Grom::Node::BLANK
        )

        @house = @house.first
        @party = @party.first
        @people = @people.sort_by(:sort_name)
        @letters = @letters.map(&:value)
        @current_person_type, @other_person_type = Parliament::Utils::Helpers::HousesHelper.person_type_string(@house)
      end

      def current_letters
        @house, @party, @people, @letters = Parliament::Utils::Helpers::RequestHelper.filter_response_data(
          @request,
          'http://id.ukpds.org/schema/House',
          'http://id.ukpds.org/schema/Party',
          'http://id.ukpds.org/schema/Person',
          ::Grom::Node::BLANK
        )

        @house = @house.first
        @party = @party.first
        @people = @people.sort_by(:sort_name)
        @letters = @letters.map(&:value)
        @current_person_type, @other_person_type = Parliament::Utils::Helpers::HousesHelper.person_type_string(@house)
      end

      def a_to_z
        @house_id = params[:house_id]
        @party_id = params[:party_id]

        @letters = Parliament::Utils::Helpers::RequestHelper.process_available_letters(ROUTE_MAP[:a_to_z].call(params))
      end

      def a_to_z_current
        @house_id = params[:house_id]
        @party_id = params[:party_id]

        @letters = Parliament::Utils::Helpers::RequestHelper.process_available_letters(ROUTE_MAP[:a_to_z_current].call(params))
      end
    end
  end
end
