import React from 'react';
import styled from 'styled-components';

import ListDiscussion from './components/ListDiscussion';

const LatestGroupDiscussions = styled(({ className, style }) => {
  const discussions = [
    {
      name: 'Jane',
      avatarURL:
        'https://s3.amazonaws.com/uifaces/faces/twitter/ripplemdk/128.jpg',
      task: {
        action: 'wrote something in',
        meta: 'How does our culture impact decisions made by the government?'
      },
      date: {
        day: '2 Sep',
        time: '1:00pm'
      }
    },
    {
      name: 'Jon',
      avatarURL: 'https://s3.amazonaws.com/uifaces/faces/twitter/jsa/128.jpg',
      task: {
        action: 'created a new discussion thread',
        meta: 'Western Sydney Phrases'
      },
      date: {
        day: '2 Sep',
        time: '1:00pm'
      }
    }
  ];
  return (
    <div className={className}>
      <header>Latest Group Discussions</header>
      <ListDiscussion discussions={discussions} />
    </div>
  );
})`
  > header {
    border-bottom: 1px solid #dadada;
    padding-bottom: 0.67em;
    margin: 1.8em 0 1.3em 0;
    color: #000000;
  }
  @media screen and (min-width: 768px) {
    width: 35%;
  }
`;

export default LatestGroupDiscussions;
