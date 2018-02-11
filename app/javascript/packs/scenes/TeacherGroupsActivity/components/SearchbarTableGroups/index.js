import React from 'react';

import SearchbarTable, {
  SearchbarButtonFilter,
  SearchbarDropdownCourse
} from 'base_components/SearchbarTable';

const SearchbarTableGroups = () => (
  <SearchbarTable>
    <SearchbarButtonFilter title="Show All" />
    <SearchbarDropdownCourse />
  </SearchbarTable>
);

export default SearchbarTableGroups;
