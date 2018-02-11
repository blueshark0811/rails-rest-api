import React from 'react';
import PropTypes from 'prop-types';
import styled from 'styled-components';
import { withRouter } from 'react-router-dom';
import { isNil } from 'ramda';

import List, { ListRow, ListRowLeft, ListRowRight } from 'base_components/List';
import LinkButton from 'base_components/LinkButton';
import iconPlayButton from './play-button.svg';
import iconExam from './exam.svg';
import './styles.css';

const ViewButton = styled(LinkButton)`
  @media screen and (min-width: 768px) {
    width: 104px;
  }
`;
const ItemListTutorials = ({ tutorials, match }) => {
  const listOfTutorials = tutorials.map(tutorial => (
    <ListRow key={tutorial.tutorialId}>
      <ListRowLeft>
        {tutorial.type === 'video' ? (
          <img src={iconPlayButton} alt="Play button icon" />
        ) : (
          <img src={iconExam} alt="Exam icon" />
        )}
        <div>
          <p>{tutorial.title}</p>
          {!isNil(tutorial.video) ? <p>{tutorial.video.length}</p> : <p />}
        </div>
      </ListRowLeft>
      <ListRowRight>
        <ViewButton url={`${match.url}/tutorials/${tutorial.id}`} text="View" />
      </ListRowRight>
    </ListRow>
  ));

  return (
    <div>
      <List className="ItemListTutorials">{listOfTutorials}</List>
    </div>
  );
};

ItemListTutorials.propTypes = {
  tutorials: PropTypes.array.isRequired
};

export default withRouter(ItemListTutorials);
