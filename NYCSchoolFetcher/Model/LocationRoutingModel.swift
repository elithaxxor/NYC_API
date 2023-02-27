//
//  LocationRoutingModel.swift
//  NYCSchoolFetcher
//
//  Created by a-robot on 2/26/23.
//

import Foundation


	struct Route : Codable {
	    var features : [Feature]!
	    
	}

	struct Feature : Codable {
	    var type : String
	    var properties : Property
	    var geometry : Geometry
	}

	struct Property : Codable {
	    var track_fid : Int
	    var track_seg_id : Int
	    var track_seg_point_id : Int
	    var ele : Int
	}

	struct Geometry : Codable {
	    var type : String
	    var coordinates :  [Double]
	}
