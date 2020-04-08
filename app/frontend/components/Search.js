import React from "react";
import algoliasearch from "algoliasearch/lite";
import {
  InstantSearch,
  connectSearchBox,
  connectStateResults,
  Hits,
  Panel,
  Pagination,
  Configure,
  SortBy,
  RefinementList
} from "react-instantsearch-dom";
import Hit from "./Hit";
import "./instantsearch_custom.scss";

const Search = props => {
  return (
    <InstantSearch
      searchClient={algoliasearch(props.app_id, props.api_key)}
      indexName="help-covid-demo"
    >
      <Configure hitsPerPage={10} />
      <div className="flex flex-col min-h-screen h-full bg-gray-100">
        <div className="flex-1 bg-gray-100">
          <div className="">
            <main className="flex-grow">
              <div className="">
                <div className="flex flex-row">
                  <CustomSearchBox />
                  <div className="mt-2 mb-6 h-12">
                    <SortBy
                      className="ml-2 mt-2 mb-2 p-3 outline-none h-12 bg-white shadow border rounded-md font-medium text-gray-800"
                      defaultRefinement="help-covid-demo"
                      items={[
                        { value: "help-covid-demo", label: "Featured" },
                        { value: "help-covid-demo-latest", label: "Latest" },
                        {
                          value: "help-covid-demo-volunteers-needed",
                          label: "Volunteers needed"
                        }
                      ]}
                    />
                  </div>
                </div>
                <div className="flex flex-row">
                  <Results>
                    <div className="flex-col w-1/4 mr-4">
                      <Panel
                        header="Type"
                        className="bg-white shadow overflow-hidden sm:rounded-md p-2 mb-2"
                      >
                        <RefinementList attribute="project_type_list" />
                      </Panel>
                      <Panel
                        header="Skills"
                        className="bg-white shadow overflow-hidden sm:rounded-md p-2 mb-2"
                      >
                        <RefinementList attribute="skill_list" />
                      </Panel>

                      <Panel
                        header="location"
                        className="bg-white shadow overflow-hidden sm:rounded-md p-2 mb-2"
                      >
                        <RefinementList attribute="location" />
                      </Panel>
                    </div>
                    <div className="flex-col w-3/4 bg-white shadow overflow-hidden sm:rounded-md">
                      <Hits hitComponent={hit => <Hit hitContent={hit} />} />
                      <Pagination />
                    </div>
                  </Results>
                </div>
              </div>
            </main>
          </div>
        </div>
      </div>
    </InstantSearch>
  );
};

const SearchBox = ({ currentRefinement, refine }) => (
  <div className="mt-2 mb-6 w-full h-12">
    <input
      className="mt-2 mb-2 p-3 w-full outline-none h-12 bg-white shadow border rounded-md font-medium  text-gray-800"
      type="search"
      placeholder="Search help with covid projects"
      value={currentRefinement}
      onChange={event => refine(event.currentTarget.value)}
    />
  </div>
);

const CustomSearchBox = connectSearchBox(SearchBox);

const Results = connectStateResults(
  ({ searchState, searchResults, children }) =>
    searchResults && searchResults.nbHits !== 0 ? (
      children
    ) : (
      <div>No results have been found for {searchState.query}.</div>
    )
);

export default Search;
