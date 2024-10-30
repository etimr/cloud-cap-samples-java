namespace my.admin.bookshop;

aspect Hierarchy {
  virtual LimitedDescendantCount : Integer64;
  virtual DistanceFromRoot       : Integer64;
  virtual DrillState             : String;
  virtual Matched                : Boolean;
  virtual MatchedDescendantCount : Integer64;
}


annotate Hierarchy with @Capabilities.FilterRestrictions.NonFilterableProperties: [
  'LimitedDescendantCount',
  'DistanceFromRoot',
  'DrillState',
  'Matched',
  'MatchedDescendantCount'
];

annotate Hierarchy with @Capabilities.SortRestrictions.NonSortableProperties: [
  'LimitedDescendantCount',
  'DistanceFromRoot',
  'DrillState',
  'Matched',
  'MatchedDescendantCount'
];
