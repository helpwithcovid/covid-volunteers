import React from "react";
import { Highlight, Snippet } from "react-instantsearch-dom";
import BtnFilter from "./BtnFilter";

const Hit = ({ hitContent, refineFromHit }) => {
  const { hit } = hitContent;
  const hitClass = hit.highlight
    ? "block transition duration-150 ease-in-out border-2 border-orange-300 bg-orange-100"
    : "block transition duration-150 ease-in-out";
  const volunteerBaseClass =
    "px-2 inline-flex text-xs leading-5 font-semibold rounded-full";
  const volunteerClass =
    hit.volunteered_users_count === 0
      ? `${volunteerBaseClass} bg-yellow-100 text-yellow-800`
      : `${volunteerBaseClass} bg-green-100 text-green-800`;
  return (
    <div className="border-t border-gray-200">
      <div className={hitClass}>
        <div className="px-4 py-4 sm:px6">
          <div className="flex flex-col md:flex-row md:items-center md:justify-between">
            <div className="text-sm leading-5 font-medium text-indigo-600 truncate">
              <a href={hit.url}>
                <Highlight hit={hit} attribute="name"></Highlight>
              </a>
            </div>
            <div className="mt-2 md:mt-0 md:ml-4 flex-shrink-0 flex">
              <span className={volunteerClass}>
                {hit.volunteered_users_count || "no volunteers"} - sign up to
                volunteer
              </span>
            </div>
          </div>
          <div className="mt-2 sm:flex sm:justify-between">
            <div className="text-sm leading-5 text-gray-500">
              <p className="mb-2">
                <Snippet hit={hit} attribute="description"></Snippet>
              </p>
            </div>
          </div>
          <div className="flex flex-col md:flex-row items-start justify-between">
            <div className="flex flex-col flex-1 justify-end flex-wrap mt-2">
              <div className="mt-2 text-sm leading-5 text-gray-500 sm:mt-0 font-bold">
                Helping with:
              </div>
              <div className="flex flex-row flex-wrap space-x-right-2 space-y-top-2">
                {hit.project_type_list.map((aType, idx) => (
                  <BtnFilter
                    facetType="project_type_list"
                    filterFunc={refineFromHit}
                    val={aType}
                    key={idx}
                  />
                ))}
              </div>
            </div>

            {hit.skill_list.length > 0 ? (
              <div className="flex flex-col md:justify-end flex-wrap mt-2">
                <div className="mt-2 text-sm md:text-right leading-5 text-gray-500 sm:mt-0 font-bold">
                  Looking for:
                </div>
                <div className="flex flex-row flex-wrap md:items-end md:content-end md:justify-end space-x-right-2 md:space-x-right-0 md:space-x-left-2 space-y-top-2">
                  {hit.skill_list.map((aSkill, idx) => (
                    <BtnFilter
                      facetType="skill_list"
                      filterFunc={refineFromHit}
                      val={aSkill}
                      key={idx}
                    />
                  ))}
                </div>
              </div>
            ) : null}
          </div>
          <div className="mt-2 sm:flex sm:justify-between">
            <div className="sm:flex">
              <div className="mt-2 flex items-center text-sm leading-5 text-gray-500 sm:mt-0">
                <svg
                  className="flex-shrink-0 mr-1.5 h-5 w-5 text-gray-400"
                  fill="currentColor"
                  viewBox="0 0 20 20"
                >
                  <path
                    fillRule="evenodd"
                    d="M5.05 4.05a7 7 0 119.9 9.9L10 18.9l-4.95-4.95a7 7 0 010-9.9zM10 11a2 2 0 100-4 2 2 0 000 4z"
                    clipRule="evenodd"
                  ></path>
                </svg>
                {hit.location}
              </div>
            </div>
            <div className="mt-2 flex items-center text-xs leading-5 text-gray-500 sm:mt-0">
              <span>
                Created the{" "}
                {new Date(hit.created_at * 1000).toLocaleDateString("en-US")}
              </span>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
};

export default Hit;
